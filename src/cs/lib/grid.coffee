class Grid
  constructor : (@state, @el, @ui, @position, @gridSize, @strokeColor) ->
    canvas = require "./canvas.coffee"
    @canvas = new canvas("#grid")
    @

  getState : ->
    @state

  render : ->
    @state = true
    @renderHorizontalLines()
    @renderVerticalLines()
    @el.innerHTML = @ui.off
  
  renderHorizontalLines : ->
    for line in [@position.start.y...@position.stop.y] by @gridSize.h
      @canvas.context.beginPath()
      @canvas.context.moveTo @position.start.x, line
      @canvas.context.lineTo @position.stop.x, line
      @canvas.context.strokeColor = @strokeColor
      @canvas.context.stroke()

  renderVerticalLines : ->
    for line in [@position.start.x...@position.stop.x] by @gridSize.w
      @canvas.context.beginPath()
      @canvas.context.moveTo line, @position.start.y
      @canvas.context.lineTo line, @position.stop.y
      @canvas.context.strokeColor = @strokeColor
      @canvas.context.stroke()

  clear : ->
    @state = false
    @canvas.clearMapBackground()
    @el.innerHTML = @ui.on

module.exports = Grid
