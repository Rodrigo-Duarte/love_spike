require('player')

function love.draw()
	love.graphics.setColor(255,255,255,255)
    love.graphics.rectangle("fill", player.x() ,player.y(), 50, 50)
    love.graphics.setColor(100,0,0,255)
    local x = (indexOf({player.facing()}, "right") - indexOf({player.facing()}, "left")) * 25 + 25
    local y = (indexOf({player.facing()}, "down") - indexOf({player.facing()}, "up")) * 25 + 25
    love.graphics.circle("fill", player.x() + x,player.y() + y, 5, 8)

    for k,artifact in ipairs(artifacts) do
    	artifact.draw()
    end

end

function love.load()
	player = createPlayer()
	artifacts = {}
	controls = { up = 0, down = 0, left = 0, right = 0 }
end

function createArtifact(owner)
	print("owner last " .. (owner.lastArtifact or "null") .. " current " .. os.clock()) --???????
	if(owner.lastArtifact and os.clock() - owner.lastArtifact < 0.05) then return {draw = function() end, update = function(dt) end } end
	local x,y ,direction = owner.x(), owner.y(), owner.facing()
	owner.lastArtifact = os.clock()
	return { 
		draw = function() love.graphics.circle("fill", x, y, 5, 5) end,
		update = function(dt) 
			if(direction == "right") then x = x + dt * 400 elseif(direction == "left") then x = x - dt * 400  elseif(direction == "up") then y = y - dt * 400 else y = y + dt*400 end
		end
	}
end

function love.update(dt)
	
	player.setX(player.x() + (player.speed * dt * (controls["right"] - controls["left"])));
	player.setY(player.y() + (player.speed * dt * (controls["down"] - controls["up"])));
	
	for k,artifact in ipairs(artifacts) do
    	artifact.update(dt)
    end

    if(controls[" "] == 1) then
    	table.insert(artifacts, createArtifact(player))
    end

end

function love.keypressed(key)
	controls[key] = 1
end

function love.keyreleased(key)
	controls[key] = 0
end

function sysout(t) --lol
	for k,v in pairs(t) do print(k,v) end
end

function indexOf( t, object ) --lol
	local result = 0
	if "table" == type( t ) then
		for i=1,#t do

			if object == t[i] then
				result = i
				break
			end
		end
	end
	return result
end