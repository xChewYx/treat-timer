module.exports = class BaseView extends Backbone.View
	initialize: (options = {}) ->
		throw new Error("State object required for views extending BaseView") unless (options.state)?
		throw new Error("Controller must be defined for the view when using BaseView") unless (options.controller)?
		
		@state = options.state
		@html = $(@template())

		@options = options
		@subViews = {}

		@controllers = {}
		@controllers[@options.controller.constructor.getNameSpace()] = @options.controller
		@controllers[@options.controller.constructor.getNameSpace()].addView(@)
		@controllers[@options.controller.constructor.getNameSpace()].trigger("viewstart:"+@cid, @)

	getName: () -> "BaseView"

	render: ->
		this

	addController: (newController, funct) ->
		@controllers[newController.getUid()] = newController
		funct(@)
		newController.addView(@)

	swapController: (oldController, newController, funct)->
		delete controllers[oldController.getUid()]
		@addController(newController, funct)

	stop: () ->
		console.log (@getName() + "stopped")		
		_.each(@controllers, (controller) -> controller.removeView(@))
		_.each(@subViews, (view) -> view.stop())
		@trigger("viewstop:" + @cid, @, @cid)
		@state = null
		@remove()
		delete @[key] for own key, value of @

	renderSubView: (region, view) ->
		@html.find(region).empty()
		@html.find(region).append(view.render().html)
		@subViews[view.cid] = view







