BaseController = require 'controllers/base_controller'
RotatorControl = require 'views/timer/rotator_control'

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

	renderSVG: () ->
		rotator = new RotatorControl({})
		rotator.paintTo(".timer_graphic_container")