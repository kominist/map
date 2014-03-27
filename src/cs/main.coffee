canvas = require("./lib/canvas.coffee")
drawable = require("./lib/drawable.coffee")
pathing = require("./lib/pathing.coffee")

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

console.log @pathing

@regions =
  snow  : [
    new drawable(snow.mainIsland, "island", @background, snow.color),
    new drawable(snow.isletNorthEast, "island", @background, snow.color),
    new drawable(snow.isletSouthWest, "island", @background, snow.color),
    new drawable(snow.isletSouthEast, "island", @background, snow.color)
  ]
for isle in @regions.snow
  isle.draw()
  @pathing.addMatrix(isle)


@decors =
  cromlech : [
    new drawable(cromlech.snow.isletNorthEast, "decor", @background, "darkgrey",
      snow.isletNorthEast
    ),
    new drawable(cromlech.snow.isletSouthWest, "decor", @background, "darkgrey",
      snow.isletSouthWest
    ),
    new drawable(cromlech.snow.isletSouthEast, "decor", @background, "darkgrey",
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

