require('luaunit')
require('collision')

TestCollision = {}

function TestCollision:testNoCollision()
  local intersection = intersection({position = {x = 0 , y = 0}, size = 50},
                                    {position = {x = 60, y = 0}, size = 30})
  assertEquals(intersection, nil)
end

function TestCollision:testCollisionNE()
  local a = {position = {x = 0 , y = 20}, size = 70}
  local b = {position = {x = 60, y = 0}, size = 30}
  local intersection1 = intersection(a, b)
  assertTable(intersection1.position, {x = 60, y = 20})
  assertTable(intersection1.size, {w = 10, h = 10})
  local intersectionReverse = intersection(b,a)
  assertTable(intersectionReverse.position, {x = 60, y = 20})
  assertTable(intersectionReverse.size, {w = 10, h = 10})
end

function TestCollision:testCollisionNW()
  local a = {position = {x = 0 , y = 0}, size = 80}
  local b = {position = {x = 60, y = 10}, size = 30}
  local intersection1 = intersection(a, b)
  assertTable(intersection1.position, {x = 60, y = 10})
  assertTable(intersection1.size, {w = 20, h = 30})
  local intersectionReverse = intersection(b,a)
  assertTable(intersectionReverse.position, {x = 60, y = 10})
  assertTable(intersectionReverse.size, {w = 20, h = 30})
end

function TestCollision:testCollisionE()
  local a = {position = {x = 0 , y = 0}, size = 30}
  local b = {position = {x = 20, y = 0}, size = 20}
  local intersection1 = intersection(a, b)
  assertTable(intersection1.position, {x = 20, y = 0})
  assertTable(intersection1.size, {w = 10, h = 20})
  local intersectionReverse = intersection(b,a)
  assertTable(intersectionReverse.position, {x = 20, y = 0})
  assertTable(intersectionReverse.size, {w = 10, h = 20})
end

LuaUnit:run()
