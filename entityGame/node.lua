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

CollisionNode = { position = {}, size = {}, collision = {} }
setmetatable(CollisionNode, { __index = Node })

function CollisionNode:new(entity)
  local rn = { position = entity:get(PositionComponent), size = entity:get(SizeComponent), collision = entity:get(CollisionComponent) }
  if not rn.position or not rn.size or not rn.collision then return nil end
  rn.__index = rn
  setmetatable(rn, CollisionNode)
  return rn
end
