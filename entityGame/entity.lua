PositionComponent = {}

function PositionComponent:new(x,y,r)
  local pos = {x = x, y = y, r = r}
  setmetatable(pos, PositionComponent)
  pos.__index = pos
  return pos
end

RenderComponent = {}

function RenderComponent:new()
  local pos = {}
  setmetatable(pos, RenderComponent)
  pos.__index = pos
  return pos
end
------------------------------------
Node = {}

RenderNode = { position = {}, image = {}}
setmetatable(RenderNode, { __index = Node })

function RenderNode:new(pos, img)
  local rn = { position = pos, image = img }
  rn.__index = rn
  setmetatable(rn, RenderNode)
  return rn
end
-------------------------------
Entity = {components = {}}

function Entity:add(comp)
  table.insert(self.components, comp)
end

function Entity:remove(comp)
  remove(self.components, comp)
end

function Entity:get(compClass)
  for i,v in ipairs(self.components) do
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
  o:add(RenderComponent:new({}))
  return o
end
-------------------------------------
Engine = {entities = {}, systems = {}, nodes = {}, drawSystems = {}}

function Engine:addEntity(entity)
  table.insert(self.entities, entity)
  local node = RenderNode:new(entity:get(PositionComponent), entity:get(RenderComponent))
  self.nodes[RenderNode] = self.nodes[RenderNode] or {}
  table.insert(self.nodes[RenderNode], node)
end

function Engine:removeEntity(entity)
  remove(self.entities, entity)
end

function Engine:addSystem(system)
  if getmetatable(system) == RenderSystem then table.insert(self.drawSystems, system)
  else table.insert(self.systems, system) end
end

function Engine:update(dt)
  for i,v in ipairs(self.systems) do
    v:update(dt, self.nodes)
  end
end

function Engine:draw()
  for i,v in ipairs(self.drawSystems) do
    v:update(dt, self.nodes)
  end
end
-----------------------------------
System = {}

function System:new()
  local s = {}
  s.__index = self
  setmetatable(s,self)
  return s
end

RenderSystem = {}
RenderSystem.__index = RenderSystem
setmetatable(RenderSystem, {__index = System})

function RenderSystem:update(dt, nodes)
  for i,v in ipairs(nodes[RenderNode]) do
    love.graphics.rectangle("fill", v.position.x, v.position.y, 10, 10) 
  end
end
---------------------------------------
