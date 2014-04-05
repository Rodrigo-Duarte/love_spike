require('Positioning')

function createPlayer(initialX,initialY)
	initialX = initialX or 50
	initialY = initialY or 50
	local player = { position = Position:new{x = initialX, y = initialY}, speed = 100, size = 50	}

	return {
		move = function(dx,dy)
      player.position:translate(dx,dy)
    end,
    forward = function(dt)
      player.position:translate(player.position.facing.x*dt,player.position.facing.y*dt)
    end,
		x =  function() return player.position.x end,
		y =  function() return player.position.y end,
		facing =  function() return player.position.facing end ,
		speed = player.speed,
    front = function()
      local halfSize = player.size/2
      local centerX = player.position.x + halfSize
      local centerY = player.position.y + halfSize
      return { x = centerX + halfSize * player.position.facing.x, y = centerY + halfSize * player.position.facing.y, facing = player.position.facing  }
    end,
    draw = function(graphics)
      graphics.setColor(0,100,100,100)
      graphics.rectangle("fill", player.position.x, player.position.y, player.size, player.size)
    end
	}
end
