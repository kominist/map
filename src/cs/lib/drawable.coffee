class Drawable
  constructor : (@element, @type, @canvas, @color, @parent = null) ->
    @coords = []
    @config = require "../data/config.coffee"
    @z = require "../data/layers.coffee"

  draw : ->
    switch @type
      when "island" then @island()
      when "decor" then @decor()
      when "hill" then @decor()
    @canvas.context.beginPath()
    switch @element.type
      when "rect" then @rect()
    @canvas.context.fillStyle = @color
    @canvas.context.fill()
    @zIndex()

  has : (name, p) ->
    @coords["#{name}"] = p unless p is null
    p

  # forms
  island : ->
    @has("x", @element.coords.left * @config.tileSize or null)
    @has("y", @element.coords.top * @config.tileSize or null)
    @has("w", @element.coords.width * @config.tileSize or null)
    @has("h", @element.coords.height * @config.tileSize or null)
  
  decor : ->
    @has("x", @parent.coords.left * @config.tileSize +
      (@element.coords.left * (@element.coords.width * @config.tileSize))
    )
    @has("y", @parent.coords.top * @config.tileSize +
      (@element.coords.top * (@element.coords.width * @config.tileSize))
    )
    @has("w", @element.coords.width * @config.tileSize)
    @has("h", @element.coords.height * @config.tileSize)

  zIndex : ->
    if @element.coords.z?
      console.log @z.color[@element.coords.z]
      @canvas.context.lineWidth = 1
      @canvas.context.strokeStyle = @z.color[@element.coords.z]
      @canvas.context.stroke()
    0

  #renderers
  rect : ->
    @canvas.context.rect(@coords["x"], @coords["y"], @coords["w"], @coords["h"])

module.exports = Drawable
