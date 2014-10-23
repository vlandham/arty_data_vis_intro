
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


animateTufte = (id, clipId) ->
  svg = d3.select(id)
  bw = 20
  width = svg.attr("width") - bw
  height = svg.attr("height") - bw

  data = []
  i = 0
  n = 10
  while i < n
    data.push({x:getRandomInt(0,width),y:getRandomInt(0,height), dir:Math.random() > 0.4})
    i += 1
  svg.selectAll(".outline").data(data)
    .enter().append("rect")
    .attr("class", "outline")
    .attr("width", bw)
    .attr("height", bw)
    .attr('x', (d) -> d.x)
    .attr('y', (d) -> d.y)
    .attr("fill", "none")
    .attr("stroke", "black")
    .attr("stroke-width", 2)
    .attr("stroke-opacity", 0.7)

  svg.select(clipId).selectAll("rect").data(data)
    .enter().append("rect")
    .attr("width", bw)
    .attr("height", bw)
    .attr('x', (d) -> d.x)
    .attr('y', (d) -> d.y)


  animate = () ->
    data.forEach (d) ->
      if d.dir
        d.x = getRandomInt(0, width)
      else
        d.y = getRandomInt(0, height)
      d.dir = if d.dir then false else true

    svg.select(clipId).selectAll("rect").data(data)
      .transition()
      .duration(3000)
      .delay((d,i) -> i * 10)
      .ease("linear")
      .attr("x", (d) -> d.x)
      .attr("y", (d) -> d.y)

    svg.selectAll(".outline").data(data)
      .transition()
      .duration(3000)
      .delay((d,i) -> i * 10)
      .ease("linear")
      .attr("x", (d) -> d.x)
      .attr("y", (d) -> d.y)

    timeout = setTimeout(animate, 3000)
  animate()

    

$ ->
  # animateTitle()
  animateTufte("#tufteSvg", "#tuftePath")
