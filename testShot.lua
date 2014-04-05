require('luaunit')
require('shot')
require('positioning')

TestShot = {}

function TestShot:testUpdate()
	local shot = Shot:new{front = function(ign) return Position:new{x=100,y= 200}  end }
	shot:update(100)
	assertTable( shot:getPosition(), { x = 100, y = -19800} )
end

LuaUnit:run()
