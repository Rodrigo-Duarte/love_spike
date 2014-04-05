require('player')
require('shot')

function love.load()
	player = createPlayer()
	artifacts = {}
	controls = { up = 0, down = 0, left = 0, right = 0 }
end

function love.update(dt)
	player.move((player.speed * dt * (controls["right"] - controls["left"])),
	            (player.speed * dt * (controls["down"] - controls["up"])))
	for k,artifact in ipairs(artifacts) do
    artifact:update(dt)
  end
  if controls[" "] == 1 then
    table.insert(artifacts, Shot:new(player))
  end
end

function love.draw()
    player.draw(love.graphics)
    for k,artifact in ipairs(artifacts) do
      artifact:draw(love.graphics)
    end
end

function love.keypressed(key)
	controls[key] = 1
end

function love.keyreleased(key)
	controls[key] = 0
end

--	for k,v in pairs(t) do print(k,v) end
