class Pathing
  constructor : (@state, @el, @ui, @options) ->
    canvas = require "./canvas.coffee"
    @canvas = new canvas("#path")
    @point = []
    @PF = require("./path.js")
    @

  getState : ->
    if @state is true
      @state = false
    else
      @state = true
    return @state

  begin : ->
    @el.innerHTML = @ui.off

  stop : ->
    @el.innerHTML = @ui.on

  render :  ->
    @pathFind = new @PF.Grid(
      Math.round(@canvas.canvas.offsetWidth / 10),
      Math.round(@canvas.canvas.offsetHeight / 10)
    )
    @AStarFinder = new @PF.AStarFinder @options
    @path = @AStarFinder.findPath(
      Math.round(@point[0].x / 10),
      Math.round(@point[0].y / 10),
      Math.round(@point[1].x / 10),
      Math.round(@point[1].y / 10),
      @pathFind
    )
    counter = 0
    for p in @path
      if not not @path[counter+1] and not not @path[counter]
        point = [
          x : @path[counter][0] * 10
          y : @path[counter][1] * 10
        ,
          x : @path[counter+1][0] * 10
          y : @path[counter+1][1] * 10
        ]
        @renderPath(point)
        counter += 1

  renderPath : (point) ->
    @canvas.context.beginPath()
    @canvas.context.moveTo(point[0].x, point[0].y)
    @canvas.context.lineTo(point[1].x, point[1].y)
    @canvas.context.lineWidth = 1
    @canvas.context.strokeColor = 'green'
    @canvas.context.stroke()

  clear : ->
    @canvas.clearMapBackground()
    
  addPoint : (e) ->
    if @canvas.isInCanvas(e)
      @canvas.encircleMouse(e, 5, "blue")
      if not @point[0]
        return @point[0] = @canvas.getMousePosition(e)
      if @point[0] and not @point[1]
        @point.push(@canvas.getMousePosition(e))
      if @hasTwoPoints()
        @render()
        @resetPoint()
    false

  resetPoint : ->
    point = @point[1]
    delete @point
    @point = [point]

  addMatrix : (@matrix) ->
    

  hasTwoPoints :  ->
    @point.length is 2

module.exports = Pathing
