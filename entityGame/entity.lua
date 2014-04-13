Entity = {components = {}}
Entity.__index = Entity

function Entity:add(comp)
  table.insert(self.components, comp)
end

function Entity:remove(comp)
  remove(self.components, comp)
end

function Entity:get(compClass)
  for i,v in ipairs(self.components) do
    for k,k2 in ipairs(v) do print(k,k2) end
    if getmetatable(v) == compClass then
      return v
    end
  end
end
---------------------------------------

Orb = { __index = Entity } --Orb herda de Entity

createOrb = function(x,y)
  local o = { }
  setmetatable(o, Orb) -- o eh uma inst de Orb
  o.__index = o -- ??
  o:add(PositionComponent:new(x,y,0))
  o:add(RenderComponent:new(love.graphics.newImage("target.png")))
  o:add(SizeComponent:new(50,50))
  local colBehavior = function(other, colbox)
    if colbox.size.w < colbox.size.h then
      other.position.x = other.position.x + colbox.size.w * (other.position.x ~= colbox.position.x and -1 or 1)  
    else
      other.position.y = other.position.y + colbox.size.h * (other.position.y ~= colbox.position.y and -1 or 1) 
    end
  end
  o:add(CollisionComponent:new(colBehavior))
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
  o:add(SizeComponent:new(50,50))
  o:add(CollisionComponent:new())
  return o
end
