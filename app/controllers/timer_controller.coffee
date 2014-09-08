BaseController = require 'controllers/base_controller'

module.exports = class TimerController extends BaseController

	@getNameSpace: () ->
		return 'TimerController'

	renderHtml: () ->	
		TimerView = require ('views/timer/timer_view')	
		@timerView = new TimerView({
      state: @state
      controller: @
    })
		@timerView.render()
		$("#root").append(@timerView.render().html)

	renderCanvas: () ->
		canvas = $('.spinner')
		canvas = canvas[0]
		stage = new createjs.Stage(canvas)
		stage.enableDOMEvents(true)
		tweens = []
		stage.enableMouseOver(10)
		createjs.Touch.enable(stage)