BaseView = require 'views/base_view'
TimerCanvasView = require 'views/timer/timer_canvas_view'
TimeController = require 'controllers/time_controller'

module.exports = class TimerView extends BaseView

	template: require 'views/templates/timer/timer_view'

	initialize: (options) ->
		super options
		@timerCanvasView = new TimerCanvasView({
			state: @state
			controller: @controllers[TimeController.getNameSpace()]
			})

	getName: () -> "TimerView"

	render: () ->
		@renderSubView('div.timer_graphic_container', @timerCanvasView)
		this


