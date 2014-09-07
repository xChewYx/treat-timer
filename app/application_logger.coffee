module.exports = class ApplicationLogger
	initialize: (options = {}) ->
		console.log("Application Logger has started")

	capture: (err) ->
		console.error (err.message)
		if err.stack
			console.error err.stack
		else
			console.error err