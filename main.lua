require('player')
require('shot')
require('control')

function love.load()
	player = createPlayer()
	artifacts = {player}
end

function love.update(dt)
	for k,artifact in ipairs(artifacts) do
    artifact:update(dt)
  end
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
