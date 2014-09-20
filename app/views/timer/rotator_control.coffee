BaseView = require 'views/base_view'
self = this

module.exports = class RotatorControl

	constructor: (options) ->
		@rotator = {}
		@rotator.options = _.extend({},RotatorControl.defaultOptions, options)
		@rotator.options.center = {}
		@rotator.options.center.x = @rotator.options.svgoptions.width / 2
		@rotator.options.center.y = @rotator.options.svgoptions.width / 2


	paintTo: (selector) ->
		this.svg = d3.select(selector).selectAll("svg")
			.data([@rotator.options])
			.enter()
			.append("svg")
			.attr("width", (d)-> d.svgoptions.width)
			.attr("height", (d)-> d.svgoptions.height)

		g = this.svg
		  .append("g")

		centerArcsGroup = g.append("g")
			.attr("id", (d)-> d.centerArcsGroup.id)

	  # Filters
		this.svg
		  .append("defs")
		  .append("filter")
		  	.attr("id", (d) -> d.filters["innerGlow"].id)
		  .append("feGaussianBlur")
		  	.attr("in", "SourceGraphic")
		  	.attr("stdDeviation",(d) -> d.filters["innerGlow"].glow.x + " " + d.filters["innerGlow"].glow.y)

		# Glowing center arc
		centerArcsGroup.append("path")
			.attr("id", (d)-> d.centerArcsGroup.centerArc.id)
			.attr("transform", (d) -> "translate(" + d.center.x + "," + d.center.y + ")")
			.attr("d",(d, i) =>
					return d3.svg.arc()
					.innerRadius(d.filters["innerGlow"].glow.innerRadius)
					.outerRadius(d.filters["innerGlow"].glow.outerRadius)
					.startAngle(d.centerArcsGroup.startAngle)
					.endAngle(d.centerArcsGroup.endAngle)()
				)
			.style("fill", (d) -> d.centerArcsGroup.fillColor)
			.attr("filter", (d) -> d.centerArcsGroup.filterId)

		# Inner circle
		centerArcsGroup.append("circle")
		  .attr("id", (d)-> d.centerArcsGroup.innderCircleId)
		  .attr("cx", (d) -> d.center.x)
		  .attr("cy", (d)-> d.center.y)
		  .attr("r",(d) -> d.centerArcsGroup.circleRadius)
		  .style("fill", (d)-> d.centerArcsGroup.circleFill)

		# centerArcsGroup.append("use")
		#   .attr("xlink:href", (d) -> "#"+d.centerArcsGroup.innderCircleId)
		#   .attr("filter", (d)-> d.centerArcsGroup.filterId)

		paddings = @rotator.options.centerArcsGroup.arcsCount * @rotator.options.centerArcsGroup.arcsAngularGap
		arcAngularSize = (360 - paddings) / @rotator.options.centerArcsGroup.arcsCount

		# # Inner surrounding arcs
		innerArcs = centerArcsGroup.append("g")

		innerArcDataArray = []
		innerArcDataArray.push(@rotator.options) for num in d3.range(@rotator.options.centerArcsGroup.arcsCount + 1)

		innerArcs.selectAll("path")
			.data(innerArcDataArray)
			.enter()
			.append("path")
			.style("fill", (d)-> d.centerArcsGroup.innerArcs.fill)
			.attr("transform", (d) -> "translate(" + d.center.x + "," + d.center.y + ")")
			.attr("d", (d, i) =>
				_innerRadius = d.centerArcsGroup.circleRadius + d.centerArcsGroup.arcsPadding
				startAngle = (arcAngularSize * i + d.centerArcsGroup.arcsAngularGap * (i + 1)).degsToRads()
				endAngle = arcAngularSize.degsToRads() + startAngle
		   
				return d3.svg.arc()
				.innerRadius(_innerRadius)
				.outerRadius(_innerRadius + d.centerArcsGroup.arcsRadius)
				.startAngle(startAngle)
				.endAngle(endAngle)()
			)

		innerArcs.selectAll("path")
			.append("animateTransform")
			.attr("attributeName", "transform")
			.attr("type", "rotate")
			.attr("from", )

		# t0 = Date.now()
		# d3.timer(()=>

		#   delta = Date.now() - t0

		#   innerArcs.attr("transform", (d)=> 
		#     return "rotate(" + delta * d.centerArcsGroup.areaSpeed +
		#       "," + d.center.x + "," + d.center.y + ")"
		#   )
		#   return false
		# )

		return this
        
	getName: () -> "RotatorControl"

	render: () ->
		this


	@defaultOptions = {
		svgoptions: {
      width: 500
      height: 500
    }
		centerArcsGroup: {
			id:"inner-area"
			areaSpeed: 0.360
			circleRadius: 32
			circleFill: "rgb(237,237,237)"
			innerCircleId: "inner-circle"
			arcsCount: 3
			arcsRadius: 12
			arcsAngularGap: 15
			arcsPadding: 10
			startAngle: 0
			endAngle: 2 * Math.PI
			fillColor: "rgba(13,215,247, .9)"
			filterId: "url(#inner-glow)"
			centerArc: {
				id: "inner-glowing-arc"
			}
			innerArcs: {
				fill: "rgb(13,215,247)"
			}
    }
		filters: { 
    	innerGlow: {
      	id: "inner-glow"
      	glow: {
          innerRadius: 38
          outerRadius: 62
          x: 7
          y: 7
      	}
    	}
    }
  };