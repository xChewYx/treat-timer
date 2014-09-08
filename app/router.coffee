module.exports = class Router extends Backbone.Router

  initialize: (options = {}) ->
    throw new Error("Router requires options.state") unless options.state?
    @state = options.state 

  routes:
    ''            : 'timer'

  timer: () -> 
    TimerController = require ('controllers/timer_controller')
    @timerController = new TimerController({state: @state})   
    @state.get('controllers')[TimerController.getNameSpace()] = @timerController

    @timerController.renderHtml()
    @timerController.renderCanvas()


    


