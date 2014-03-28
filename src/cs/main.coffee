canvas = require("./lib/canvas.coffee")
drawable = require("./lib/drawable.coffee")
pathing = require("./lib/pathing.coffee")
image = require("./lib/image.coffee")

snow = require("./data/island/snow.coffee")
cromlech = require("./data/decor/cromlech.coffee")
hill = require("./data/hill/snow.coffee")

gridUi = require("./ui/event/grid.coffee")
positionUi = require("./ui/event/position.coffee")
pathUi = require("./ui/event/path.coffee")

@background = new canvas("#canvas")
gridUi(@background)
positionUi(@background)
@pathing = pathUi(@background)
@background.setMapBackground()
@assets = new canvas("#assets")

console.log @pathing.pathFind

@regions =
  snow  : [
    new drawable(snow.mainIsland, "island", @background, snow.color),
    new drawable(snow.isletNorthEast, "island", @background, snow.color),
    new drawable(snow.isletSouthWest, "island", @background, snow.color),
    new drawable(snow.isletSouthEast, "island", @background, snow.color)
  ]
for isle in @regions.snow
  isle.draw()
  isle.gridize(@pathing.pathFind)


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
decor.draw() for decor in @decors.cromlech


@hills =
  snow : [
    new drawable(hill.snow.lowNorthWest, "hill", @background, snow.color,
      snow.mainIsland
    )
  ]
hill.draw() for hill in @hills.snow

console.log @assets
@images =
  snow :
    cromlech : [
      new image(@assets, @decors.cromlech[0], "./images/cromlech.svg")
    ,
      new image(@assets, @decors.cromlech[1], "./images/cromlech.svg")
    ,
      new image(@assets, @decors.cromlech[2], "./images/cromlech.svg")
    ]
