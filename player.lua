function createPlayer()

	local player = { x = 50,		y = 50,		speed = 100,		facing = "left"} --intiial values

	local get = function(o, att) return o[att] end

	return {
		setX = function (x) 
			oldX = player.x 
			player.x = x
			if(oldX ~= player.x) then
				if(player.x < oldX) then player.facing = "left" else player.facing = "right" end
			end
		end,
		setY = function (x) 
			oldX = player.y 
			player.y = x
			if(oldX ~= player.y) then
				if(player.y < oldX) then player.facing = "up" else player.facing = "down" end
			end
		end,
		x =  function() return get(player, "x") end,
		y =  function() return get(player, "y") end,
		facing =  function() return get(player, "facing") end ,
		speed = get(player, "speed") -- constant
	}
end