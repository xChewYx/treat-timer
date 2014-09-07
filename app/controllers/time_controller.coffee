BaseController = require 'controllers/base_controller'

module.exports = class TimerController extends BaseController

	@getNameSpace: () ->
		return 'TimerController'
	
	initialize: (options = {}) ->
		super options
