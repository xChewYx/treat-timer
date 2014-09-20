BaseView = require 'views/base_view'

module.exports = class TimerView extends BaseView

	template: require 'views/templates/timer/timer_view'

	initialize: (options) ->
		super options

	getName: () -> "TimerView"

	render: () ->
		this
