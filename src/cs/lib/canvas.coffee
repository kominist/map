class Canvas
  constructor : (canvas) ->
    @canvas = document.querySelector(canvas) or document.getElementById(canvas)
    @canvas.width = @canvas.offsetWidth
    @canvas.height = @canvas.offsetHeight
    @context = @canvas.getContext "2d"
    @

  getMousePosition : (event) ->
    @position =
      x : event.pageX or (
        event.clientX +
        document.body.scrollLeft +
        document.documentElement.scrollLeft
      )
      y : event.pageY or (
        document.body.scrollTop +
        document.documentElement.scrollTop
      )

  isInCanvas : (event) ->
    @getMousePosition(event)
    if @position.y < 32
      delete @position
      return false
    true
  
  # backgrounds
  setMapBackground : ->
    @context.rect(0, 0, @canvas.width, @canvas.height)
    @context.fillStyle = "lightblue"
    @context.fill()
    @

  clearMapBackground : ->
    @context.clearRect(0, 0, @canvas.width, @canvas.height)

  # paths
  setPath : ->
    if not @path.start
      @path.start = x : @position.x, y : @position.y
      return false
    if not @path.end and @path.start
      @path.end = x : @position.x, y : @position.y
      return true
    if @path.start and @path.end
      @path.start = @path.end
      @path.end = x : @position.x, y : @position.y
      return true

  allowPath : ->
    return @pathing is false if @pathing = true
    @pathing = true

  # effects
  encircleMouse : (event, radius = 5, strokeColor = 'black') ->
    @getMousePosition(event)
    circle =
      x : @position.x
      y : @position.y
      radius : radius
    @context.beginPath()
    @context.arc(
      circle.x,
      circle.y,
      circle.radius,
      0,
      2 * Math.PI
    )
    @context.lineWidth = 1
    @context.strokeStyle = strokeColor
    @context.stroke()
    circle

module.exports = Canvas

