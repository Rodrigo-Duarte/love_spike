require('luaunit')
require('target')

TestTarget = {}

function TestTarget:testDestroy()
  local target = Target:new(50,50)
  assertEquals(target:isDestroyed(), false)
  target:damage(10)
  assertEquals(target:isDestroyed(), true)
end

LuaUnit:run()
