class Canvas
  constructor : (canvas) ->
    @canvas = document.querySelector(canvas) or document.getElementById(canvas)
    @canvas.width = @canvas.offsetWidth
    @canvas.height = @canvas.offsetHeight
    @context = @canvas.getContext "2d"
    @context.scale(1, 1)
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

  needleMousePosition : (event, radius = 5, strokeColor = 'black') ->
    @getMousePosition(event)
    needle =
      stick :
        x : @position.x
        y : @position.y - 20
        w : 1
        h : 20
      circle :
        x : @position.x
        y : @position.y - 20 - Math.round(radius / 3)
        radius : radius
        stroke : 1
      text :
        x : @position.x + radius + 2
        y : @position.y - 20

    @context.beginPath()
    @context.arc(
      needle.circle.x,
      needle.circle.y,
      needle.circle.radius,
      0,
      2 * Math.PI
    )
    @context.lineWidth = needle.circle.stroke
    @context.strokeStyle = strokeColor
    @context.stroke()
    @context.closePath()
    @context.beginPath()
    @context.rect(
      needle.stick.x,
      needle.stick.y,
      needle.stick.w,
      needle.stick.h
    )
    @context.fillStyle = strokeColor
    @context.fill()
    @context.closePath()
    @context.beginPath()
    @context.fillStyle = "#1a1a1a"
    @context.fillText(
      "#{@position.x}, #{@position.y}",
      needle.text.x,
      needle.text.y
    )
    @context.closePath()

  # scale
  changeZoom : (scale) ->
    @context.scale(scale.w, scale.h)
  
module.exports = Canvas

