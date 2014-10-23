
animateTitle = () ->
  svg = d3.select("#titleSvg")
  width = svg.attr("width")
  height = svg.attr("height")
  console.log(height)
  m = 40
  r = 6
  data = bumpLayer(m, 0.1)
  xScale = d3.scale.ordinal()
    .domain(d3.range(m))
    .rangeRoundBands([0, width], .08)
  yMax = d3.max(data, (d) -> d.y)
  yScale = d3.scale.linear()
    .domain([0, yMax])
    .range([(height / 2 ) - r, r])

  svg.select("#topPath").selectAll('circle').data(data)
    .enter().append("circle")
    .attr("cx", (d) -> xScale(d.x))
    .attr("cy", (d) -> yScale(d.y))
    .attr("r", r)
    # .attr("x", (d) -> xScale(d.x))
    # .attr("y", 0)
    # .attr("opacity", 0.4)
    # .attr("height", (d) -> yScale(d.y))
    # .attr("width", xScale.rangeBand())
  animate = () ->
    data = bumpLayer(m, 0.1)
    yMax = d3.max(data, (d) -> d.y)
    yScale.domain([0,yMax])

    svg.select("#topPath").selectAll("circle").data(data)
      .transition()
      .duration(3000)
      .delay((d,i) -> i * 10)
      .ease("linear")
      .attr("cy", (d) -> yScale(d.y))
    timeout = setTimeout(animate, 3000)
  animate()


    

$ ->
  animateTitle()
