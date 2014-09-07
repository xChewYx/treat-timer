BaseView = require 'views/base_view'

module.exports = class BaseController
	_.extend this.prototype, Backbone.Events

	getName: () -> "BaseController"

	@getNameSpace: () ->
		throw new Error(@getName()+"must override getNameSpace")

	constructor: (options) ->
		throw new Error("State object required for controller ["+@getName()+"] extending BaseController") unless (options.state)?
		@state = options.state
		@options = options

		@uid = _.uniqueId('con') 

		@state.get('controllers')[@constructor.getNameSpace()] = @

		@views = {}

	addView: (view) ->
		if(view instanceof BaseView)
			if(@views[view.cid] == undefined)
				@views[view.cid] = view
				@listenTo(view, "viewstop:" +view.cid, @removeView)
		else
			window.appLogger.capture(new Error ("BaseController error: In " +@getName()+", can not add view that does not extend BaseView. View: "+ view.getName()))

	removeView: (view) ->
		if @views[view.cid]
			@stopListening(view)
			delete @views[view.cid]

	getViews: () ->
		return @views

	# To swap the controller for all views owned by this controller, pass in the new controller
	# and a method that will be run for each view. Presumably, this method with handle re-binding the 
	# views to appropriate listeners.
	swapControllers: (newController, funct, remove ) ->
		_.each(@views, (view)-> view.swapController(@, newController, funct))
		@trigger("controller:swapped", newController)
		if remove
			@stop()		

	getUid: () ->
		return @uid

	stop: () ->
		@state = null
		@trigger("controller:stopped", @uid , @)
		@stopListening()
		delete @[key] for own key, value of @


