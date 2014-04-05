require('luaunit')
require('control')

TestControl = {}

function TestControl:testInputPress()
  assertEquals(controls[" "], nil)
  controls.keyPressed(" ")
  assertEquals(controls[" "], 1)
end

function TestControl:testInputRelease()
  controls.keyPressed(" ")
  controls.keyReleased(" ")
  assertEquals(controls[" "], 0)
end

LuaUnit:run()
