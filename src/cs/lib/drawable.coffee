class Drawable
  constructor : (@element, @type, @canvas, @color, @parent = null, config) ->
    @coords = []
    @config = require "../data/config.coffee"
    @z = require "../data/layers.coffee"

  draw : ->
    switch @type
      when "island" then @island()
      when "decor" then @decor()
      when "hill" then @decor()
      when "shop" then @decor()
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
      @canvas.context.lineWidth = 1
      @canvas.context.strokeStyle = @z.color[@element.coords.z]
      @canvas.context.stroke()
    0

  gridize : (grid) ->
    #row = @canvas.canvas.offsetWidth / 10
    #for coordX in [ @coords["x"]/10...(@coords["x"] + @coords["w"])/10 ]
      #for coordY in [ @coords["y"]/10...(@coords["y"] + @coords["h"])/10 ]
        #grid.setWalkableAt(
          #Math.round(coordX),
          #Math.round(coordY)
        #)
        #x= coordX
        #y = coordY
        #@canvas.context.beginPath()
        #@canvas.context.rect(x*10,y*10,x+10,y+10)
        #@canvas.context.fillStyle = "green"
        #@canvas.context.fill()
      
  #renderers
  rect : ->
    @canvas.context.rect(@coords["x"], @coords["y"], @coords["w"], @coords["h"])

  # zoom
  changeScale : (size = 64) ->
    @config.tileSize = size
module.exports = Drawable
