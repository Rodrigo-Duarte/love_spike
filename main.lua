require('player')
require('shot')
require('control')
require('target')
require('collision')

function love.load()
	player = createPlayer()
  local target = Target:new(200,100)
	artifacts = {player, target}
end

function love.update(dt)
	for k,artifact in ipairs(artifacts) do
    artifact:update(dt)
  end
  Collider:checkCollisions(artifacts)
  if controls[" "] == 1 then
    table.insert(artifacts, Shot:new(player))
  end
end

function love.draw()
    for k,artifact in ipairs(artifacts) do
      artifact:draw(love.graphics)
    end
end

--	for k,v in pairs(t) do print(k,v) end
