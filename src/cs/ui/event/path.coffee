module.exports = (canvasObject) ->
  canvas = canvasObject.canvas
  Path = require "../../lib/pathing.coffee"
  @path = new Path(
    false,
    document.querySelector("button[name=allow-path]"),
    {off : "terminer chemin", on : "commencer chemin"},
    {dontCrossCorners : true, allowDiagonal : true}
  )
  
  @path.el.addEventListener "click", (e) =>
    @path.getState()
    if @path.state is true
      return @path.begin()
    @path.stop()
   
  document.addEventListener "click", (e) =>
    if @path.state is true
      return @path.addPoint(e)
    false

  return @path
