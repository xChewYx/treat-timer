
module.exports = class ApplicationState extends Backbone.Model
	initialize: (options = {}) ->
		super options

	# We dont need to save this back to any server
	save: () ->
		console.log("save called")

	fetch: () -> 
		console.log ("fetch called")


	