module.exports = (@canvas, @position, @imageUrl) ->
  config = require "../data/config.coffee"
  img = new Image()
  img.onload = =>
    @canvas.context.drawImage(
      img,
      @position.coords["x"],
      @position.coords["y"],
      @position.coords["w"],
      @position.coords["h"]
    )
  img.src = @imageUrl
