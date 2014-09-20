Router = require 'router'
ApplicationState = require 'models/application_state'
ApplicationLogger = require 'application_logger'

$ () ->
	Number.prototype.degsToRads = () ->
    return d3.scale.linear().domain([0, 360]).range([0, 2 * Math.PI])(this)
    
  appState = new ApplicationState({controllers: {}})
	window.appLogger = new ApplicationLogger()
	appRouter = new Router({state: appState})
	Backbone.history.start pushState: true