module.exports = (canvasObject) ->
  @elPosition =  document.querySelector "#position"
  document.addEventListener "mousemove", (e) =>
    if canvasObject.isInCanvas(e)
      @position = canvasObject.getMousePosition(e)
      @elPosition.innerHTML = """
        x : #{@position.x}
        y : #{@position.y}
      """
    else
      @elPosition.innerHTML = """
        x : 0
        y : 0
      """
