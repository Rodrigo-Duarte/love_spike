require('engine')
require('entity')
require('control')
require('component')
require('node')
require('system')

artifacts = {}
remove = function(atable, value)
  for i,v in ipairs(atable) do
    if v == value then print(atable, i, v, value) table.remove(atable, i) return end
  end
end

function love.load()
  local aorb = createOrb(350, 400)
  Engine:addEntity(aorb)

  local player = createPlayer(300,400)
  Engine:addEntity(player)

  Engine:addSystem(ControlSystem:new())
  Engine:addSystem(MoveSystem:new())
  Engine:addSystem(RenderSystem:new())
  Engine:addSystem(CollisionSystem:new())
end

function love.update(dt)
  Engine:update(dt)
end

function love.draw()
  Engine:draw()
end

--	for k,v in pairs(t) do print(k,v) end
