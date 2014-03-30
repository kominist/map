canvas = require("./lib/canvas.coffee")
drawable = require("./lib/drawable.coffee")
pathing = require("./lib/pathing.coffee")
image = require("./lib/image.coffee")

snow = require("./data/island/snow.coffee")
cromlech = require("./data/decor/cromlech.coffee")
igloo = require("./data/decor/igloo.coffee")
hill = require("./data/hill/snow.coffee")
shop = require("./data/shop/snow.coffee")

gridUi = require("./ui/event/grid.coffee")
positionUi = require("./ui/event/position.coffee")
pathUi = require("./ui/event/path.coffee")
pingUi = require("./ui/event/ping.coffee")

@background = new canvas("#canvas")
gridUi(@background)
positionUi(@background)
pingUi(@background)
@pathing = pathUi(@background)
@assets = new canvas("#assets")

@regions =
  snow  : [
    new drawable(snow.mainIsland, "island", @background, snow.color),
    new drawable(snow.isletNorthEast, "island", @background, snow.color),
    new drawable(snow.isletSouthWest, "island", @background, snow.color),
    new drawable(snow.isletSouthEast, "island", @background, snow.color)
  ]

@decors =
  cromlech : [
    new drawable(cromlech.snow.isletNorthEast, "decor", @background,
      "transparent",
      snow.isletNorthEast
    ),
    new drawable(cromlech.snow.isletSouthWest, "decor", @background,
      "transparent",
      snow.isletSouthWest
    ),
    new drawable(cromlech.snow.isletSouthEast, "decor", @background,
      "transparent",
      snow.isletSouthEast
    )
  ]
  igloo : [
    new drawable(igloo.snow.isletSouthWest, "decor", @background,
    "transparent",
    snow.isletSouthWest
    )
  ]

@hills =
  snow : [
    new drawable(hill.snow.lowNorthWest, "hill", @background, snow.color,
      snow.mainIsland
    )
  ]

@shops =
  snow :
    general : [
      new drawable(shop.snow.general, "shop", @background,
        "brown", snow.mainIsland
      )
    ]
    colors : [
    
    ]
@images =
  snow :
    cromlech : [
      new image(@assets, @decors.cromlech[0], "./images/cromlech.svg")
    ,
      new image(@assets, @decors.cromlech[1], "./images/cromlech.svg")
    ,
      new image(@assets, @decors.cromlech[2], "./images/cromlech.svg")
    ]
    igloo : [
      new image(@assets, @decors.igloo[0], "./images/igloo.svg")
    ]

@draw = (@scale = 64) =>
  @background.clearMapBackground()
  @assets.clearMapBackground()
  @background.setMapBackground()
  for isle in @regions.snow
    isle.changeScale(@scale)
    isle.draw()
    isle.gridize(@pathing.pathFind)

  for decor in @decors.cromlech
    decor.changeScale(@scale)
    decor.draw()
    for asset in @images.snow.cromlech
      new image(@assets, decor, "./images/cromlech.svg")
  for decor in @decors.igloo
    decor.changeScale(@scale)
    decor.draw()
    for asset in @images.snow.igloo
      new image(@assets, decor, "./images/igloo.svg")

  for hill in @hills.snow
    hill.changeScale(@scale)
    hill.draw()

  for shop in @shops.snow.general
    shop.changeScale(@scale)
    shop.draw()


@draw()
zoom = document.querySelector("input[name=zoom]")
zoom.addEventListener "input", (e) =>
  @draw(zoom.value * 64 / 100)
