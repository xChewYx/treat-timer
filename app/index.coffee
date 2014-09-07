Router = require 'router'
ApplicationState = require 'models/application_state'
ApplicationLogger = require 'application_logger'

$ () ->
	appState = new ApplicationState({controllers: {}})
	window.appLogger = new ApplicationLogger()
	appRouter = new Router({state: appState})
	Backbone.history.start pushState: true