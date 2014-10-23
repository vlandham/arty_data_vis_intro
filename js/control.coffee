
animateTitle = () ->
  svg = d3.select("#titleSvg")
  console.log(svg.attr("width"))
  data = (num for num in [1..40])
  console.log(data)
  svg.selectAll('circle').data(data)
    .enter().append("circle")
    .attr("cx", (d) -> d)
    .attr("cy", (d) -> d)
    .attr("r", 4)

    

$ ->
  animateTitle()
