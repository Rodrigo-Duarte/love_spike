artifacts = {}
remove = function(atable, value)
  for i,v in ipairs(atable) do
    if v == value then print(atable, i, v, value) table.remove(atable, i) return end
  end
end

require('anim')
require('player')
require('shot')
require('control')
require('target')
require('collision')

function love.load()
	local player = createPlayer()
  local target = Target:new(200,100)
  table.insert(artifacts, player)
  table.insert(artifacts, target)
end

function love.update(dt)
	for k,artifact in ipairs(artifacts) do
    artifact:update(dt)
  end
  Collider:checkCollisions(artifacts)
end

function love.draw()
    for k,artifact in ipairs(artifacts) do
      artifact:draw(love.graphics)
    end
end

--	for k,v in pairs(t) do print(k,v) end
