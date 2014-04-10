require('control')

PositionComponent = {x = 0, y = 0, r = 0}
PositionComponent.__index = PositionComponent

function PositionComponent:new(x,y,r)
  local pos = {x = x, y = y, r = r}
  setmetatable(pos, PositionComponent)
  pos.__index = pos
  return pos
end

RenderComponent = { image = {}}
RenderComponent.__index = RenderComponent

function RenderComponent:new(image)
  local pos = {image = image }
  setmetatable(pos, RenderComponent)
  pos.__index = pos
  return pos
end

ControlComponent = { accel = 100 }
ControlComponent.__index = ControlComponent

function ControlComponent:new()
  local pos = {}
  setmetatable(pos, ControlComponent)
  pos.__index = pos
  return pos
end

function ControlComponent:getPressed(key)
  return controls[key] == 1
end

function ControlComponent:getInt(key)
  if self:getPressed(key) then return 1 else return 0 end
end

VelocityComponent = {x = 0, y = 0, r = 0}
VelocityComponent.__index = VelocityComponent

function VelocityComponent:new(x,y,r)
  local pos = {x = x, y=y, r=r}
  setmetatable(pos, VelocityComponent)
  pos.__index = pos
  return pos
end

------------------------------------
Node = {}

RenderNode = { position = {}, image = {} }
setmetatable(RenderNode, { __index = Node })

function RenderNode:new(entity)
  local rn = { position = entity:get(PositionComponent), image = entity:get(RenderComponent) }
  if not rn.position or not rn.image then return nil end
  rn.__index = rn
  setmetatable(rn, RenderNode)
  return rn
end

ControlNode = { control = {}, velocity = {} }
setmetatable(ControlNode, { __index = Node } )

function ControlNode:new(entity)
  local rn = { control = ControlComponent:new(), velocity = entity:get(VelocityComponent) }
  if not rn.control or not rn.velocity then return nil end
  rn.__index = rn
  setmetatable(rn, ControlNode)
  return rn
end

MoveNode = { position = {}, velocity = {} }
setmetatable(MoveNode, { __index = Node })

function MoveNode:new(entity)
  local rn = { position = entity:get(PositionComponent), velocity = entity:get(VelocityComponent) }
  if not rn.position or not rn.velocity then return nil end
  rn.__index = rn
  setmetatable(rn, MoveNode)
  return rn
end

-------------------------------
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
Engine = {entities = {}, systems = {}, nodes = {}, drawSystems = {}}

function Engine:addEntity(entity)
  table.insert(self.entities, entity)
  for i,nodeClass in ipairs({RenderNode, ControlNode, MoveNode}) do
    local node = nodeClass:new(entity)
    if node then
      self.nodes[nodeClass] = self.nodes[nodeClass] or {}
      table.insert(self.nodes[nodeClass], node)
    end
  end
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
    love.graphics.draw(v.image.image, v.position.x, v.position.y,v.position.r,1,1, 25,25)
  end
end

MoveSystem = {}
MoveSystem.__index = MoveSystem
setmetatable(MoveSystem, {__index = System})

function MoveSystem:update(dt, nodes)
  for i,v in ipairs(nodes[MoveNode]) do
    print(math.sin(v.position.r), math.cos(v.position.r), v.position.r)
    v.position.x = v.position.x + (v.velocity.x * dt) * math.sin(v.position.r) + (-v.velocity.y * dt) * math.sin(v.position.r)
    v.position.y = v.position.y + v.velocity.y * dt * math.cos(v.position.r) + (v.velocity.x * dt) * math.cos(v.position.r)
    v.position.r = v.position.r + v.velocity.r * dt
  end
end

ControlSystem = {}
ControlSystem.__index = ControlSystem
setmetatable(ControlSystem, { __index = System })

function ControlSystem:update(dt, nodes)
  for i,v in ipairs(nodes[ControlNode]) do
    v.velocity.x = v.velocity.x + (dt * v.control.accel * (v.control:getInt("e") - v.control:getInt("q")))
    v.velocity.y = v.velocity.y + (dt * v.control.accel * (v.control:getInt("s") - v.control:getInt("w")))
    v.velocity.r = v.velocity.r + (dt * v.control.accel/50 * (v.control:getInt("d") - v.control:getInt("a")))
  end
end
---------------------------------------
