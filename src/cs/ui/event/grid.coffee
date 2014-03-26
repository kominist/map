config = require("../../data/config.coffee")

module.exports = (canvasObject) ->
  canvas = canvasObject.canvas
  Grid = require "../../lib/grid.coffee"
  @grid = new Grid(
    false,
    document.querySelector("button[name=grid]"),
    { off : "cacher grille", on : "afficher grille" },
    { start : { x : 0, y : 0 }, stop : { x : canvas.width, y : canvas.height }},
    config.gridSize,
    "#1a1a1a"
  )
  @grid.el.addEventListener "click", =>
    if @grid.getState()
      return @grid.clear()
    @grid.render()

