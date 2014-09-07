module.exports = class Router extends Backbone.Router

  initialize: (options = {}) ->
    throw new Error("Router requires options.state") unless options.state?
    @state = options.state 

  routes:
    ''            : 'timer'

  timer: () ->

    TimerController = require ('controllers/time_controller')
    timerController = new TimerController({state: @state})
    @state.get('controllers')[TimerController.getNameSpace()] = timerController
    
    TimerView = require ('views/timer/timer_view')
    timerView = new TimerView({
      state: @state
      controller: timerController
    })

    $("#root").append(timerView.render().html)


