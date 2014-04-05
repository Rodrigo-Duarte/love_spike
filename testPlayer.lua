require('luaunit')
require('player')

TestPlayer = {}

function TestPlayer:setUp() end
function TestPlayer:tearDown() end

function TestPlayer:testInitialValues()
	local player = createPlayer()
	assertEquals( player.x() , 50 )
	assertEquals( player.y() , 50 )
	assertTable( player.facing() , { x = 0, y = -1} )
end

function TestPlayer:testMove()
	local player = createPlayer()
	player.move(10,5)
	assertEquals(player.x(), 60)
  assertEquals(player.y(), 55)
	assertTable( player.facing() , { x = 0, y = 1} )
end

function TestPlayer:testForward()
	local player = createPlayer(50,50)
	assertTable( player.facing() , { x = 0, y = -1} )
	player.forward(10)
	assertTable( player.facing() , { x = 0, y = -1} )
	assertEquals(player.x(), 50)
  assertEquals(player.y(), 40)
end

function TestPlayer:testFront()
  local player = createPlayer(50,50)
  assertTable(player.front(), { x = 75, y = 50 })
  assertTable(player.facing(), { x = 0, y = -1 })
  player.move(50,0)
  assertTable(player.front(), { x = 150, y = 75 })
  assertTable(player.facing(), { x = 1, y = 0 })
  player.move(-50,0)
  assertTable(player.front(), { x = 50, y = 75 })
  assertTable(player.facing(), { x = -1, y = 0 })
  player.move(0,50)
  assertTable(player.front(), { x = 75, y = 150 })
  assertTable(player.facing(), { x = 0, y = 1 })
end

function TestPlayer:testUpdate()
  local player = createPlayer(50,90)
  player.move(0,10)
  controls["up"] = 1
  player:update(1)
  assertEquals(player.x(), 50)
  assertEquals(player.y(), 0)
end

LuaUnit:run()
