BaseView = require 'views/base_view'

module.exports = class TimerCanvasView extends BaseView

	initialize: (options) ->
		super options

	template: require 'views/templates/timer/timer_canvas_view'

	getName: () -> "TimerCanvasView"

	render: () ->
		this