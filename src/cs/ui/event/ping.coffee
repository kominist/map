module.exports = (canvasObject) ->
  canvas = canvasObject.canvas
  @elSavedPosition = document.querySelector("#saved-position")
  document.addEventListener "click", (e) =>
    if canvasObject.isInCanvas(e)
      canvasObject.needleMousePosition(e, 5, "darkgreen")

