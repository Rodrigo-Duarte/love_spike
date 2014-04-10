Orb = { __index = Entity } --Orb herda de Entity

createOrb = function(x,y)
  local o = { }
  setmetatable(o, Orb) -- o eh uma inst de Orb
  o.__index = o -- ??
  o:add(PositionComponent:new(x,y,0))
  o:add(RenderComponent:new(love.graphics.newImage("target.png")))
  return o
end

-------------------------------

Player = { __index = Entity }

createPlayer = function(x,y)
  local o = { components = {} }
  setmetatable(o, Player)
  o.__index = o
  o:add(PositionComponent:new(x,y,0))
  o:add(VelocityComponent:new(0,0,0))
  o:add(RenderComponent:new(love.graphics.newImage("triangle.png")))
  o:add(ControlComponent:new())
  return o
end
