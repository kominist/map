class Asset
  constructor : (@canvas, @position, @imageUrl) ->
    @img = new Image()
    @img.src = @imageUrl
    @img.onload = =>
      @load()

  load : ->
    @canvas.context.drawImage(
      @img,
      @position.coords["x"],
      @position.coords["y"],
      @position.coords["w"],
      @position.coords["h"]
    )

  setPosition : (@position) ->
    
module.exports = Asset
