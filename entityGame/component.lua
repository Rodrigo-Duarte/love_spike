PositionComponent = {x = 0, y = 0, r = 0}
PositionComponent.__index = PositionComponent

function PositionComponent:new(x,y,r)
  local pos = {x = x, y = y, r = r}
  setmetatable(pos, PositionComponent)
  pos.__index = pos
  return pos
end

SizeComponent = { h = 0, w = 0 }
SizeComponent.__index = SizeComponent

function SizeComponent:new(w,h)
  local pos = { h = h, w = w }
  setmetatable(pos, SizeComponent)
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

ControlComponent = { accel = 500 }
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

VelocityComponent = {x = 0, y = 0, r = 0, max = 0}
VelocityComponent.__index = VelocityComponent

function VelocityComponent:new(x,y,r, max)
  local pos = {x = x, y=y, r=r, max = max}
  setmetatable(pos, VelocityComponent)
  pos.__index = pos
  return pos
end

CollisionComponent = { notify = function() end}
CollisionComponent.__index = CollisionComponent

function CollisionComponent:new(behavior)
  local pos = { notify = behavior }
  setmetatable(pos, CollisionComponent)
  pos.__index = pos
  return pos
end
------------------------------------
