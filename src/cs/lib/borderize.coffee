class Borderize
  constructor : (@isle) ->
    @position = @isle.position
  
  rect : ->
    @renderSide(
      padding :
        x : 4
        y : 0
      from :
        x : @position.x,
        y : @position.y
      to :
        x : @position.x + @position.w,
        y : @position.y
    )
    @renderSide(
      padding :
        x : 0
        y : 4
      from :
        x : @position.x + @position.w,
        y : @position.y
      to :
        x : @position.x + @position.w,
        y : @position.y + @position.h
    )
    @renderSide(
      padding :
        x : 4
        y : 0
      from :
        x : @position.x + @position.w,
        y : @position.y + @position.h
      to :
        x : @position.x,
        y :@position.y + @position.h
    )
    @renderSide(
      padding :
        x : 0
        y : 4
      from :
        x : @position.x
        y : @position.y + @position.h
      to :
        x : @position.x
        y : @position.y
    )

  renderSide : (@coords) ->
    @randomBorder()
    counter = 0
    for x in [@coords.from.x..@coords.to.x]
      for y in [@coords.from.y..@coords.to.y]
        @downLine(@upLine(counter, x, y, @coords.padding))
        counter += 1

  upLine : (counter, x, y, padding) ->
    after = {}
    if padding.x is 0
      padding.x = Math.floor(Math.random()*5+3)
      after.x = x
      after.y = null
    if padding.y is 0
      padding.y = Math.floor(Math.random()*5+3)
      after.x = null
      after.y = y
    @canvas.context.beginPath()
    @canvas.context.moveTo(x, y)
    @canvas.context.lineTo(x + padding.x, y + padding.y)
    return [x + padding.x, y + padding.y, after]

  downLine : (position) ->
    if position is false
      return false
    x = position[0]
    y = position[1]
    after = position[2]
    @canvas.context.lineTo(after.x or x, after.y or y)
    @canvas.context.closePath()
    @canvas.context.stroke()


module.exports = Borderize
