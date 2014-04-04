require('luaunit')
require('player')

TestPlayer = {}

function TestPlayer:setUp() end
function TestPlayer:tearDown() end

function TestPlayer:testInitialValues()
	local player = createPlayer()
	assertEquals( player.x() , 50 )
	assertEquals( player.y() , 50 )
	assertEquals( player.facing() , "left" )
end

LuaUnit:run()