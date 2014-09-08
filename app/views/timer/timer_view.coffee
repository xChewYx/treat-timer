BaseView = require 'views/base_view'
TimerCanvasView = require 'views/timer/timer_canvas_view'

module.exports = class TimerView extends BaseView

	template: require 'views/templates/timer/timer_view'

	initialize: (options) ->
		super options
		@timerCanvasView = new TimerCanvasView({
			state: @state
			controller: @controllers[require('controllers/timer_controller').getNameSpace()]
			})

	getName: () -> "TimerView"

	render: () ->
		@renderSubView('div.timer_graphic_container', @timerCanvasView)
		this
