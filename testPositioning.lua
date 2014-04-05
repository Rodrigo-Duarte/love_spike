require('luaunit')
require('positioning')

TestPositioning = {}

function TestPositioning:testTranslate()
  local point = Position:new()
  assertEquals(point.x, 0)
  assertEquals(point.y, 0)
  point:translate(5, 10)
  assertEquals(point.x, 5)
  assertEquals(point.y, 10)
end

function TestPositioning:testFacing()
  local position = Position:new()
  assertTable(position.facing, {x = 0, y = -1 })
  position:translate(5, 0)
  assertTable(position.facing, {x = 1, y = 0 })
end

function TestPositioning:testDirections()
  assertTable(Directions:which(0,0,1,0), { x = 1,y = 0 })
  assertEquals(Directions:which(1,0,1,0), nil) 
end

LuaUnit:run()

