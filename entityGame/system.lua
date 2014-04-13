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

CollisionSystem = {}
CollisionSystem.__index = CollisionSystem
setmetatable(CollisionSystem, { __index = System })

function CollisionSystem:update(dt, nodes)
  for i1,v1 in ipairs(nodes[CollisionNode]) do
    for i2,v2 in ipairs(nodes[CollisionNode]) do
      if i1 ~= i2  and self:isColliding(v1,v2) then
        local intersect = self:intersection(v1,v2)
        v1.collision.notify(v2, intersect)
        v2.collision.notify(v1, intersect)
      end
    end
  end
end

function CollisionSystem:intersection(a, b)
  local x11, y11, x12, y12 = a.position.x, a.position.y, a.position.x + a.size.w, a.position.y + a.size.h
  local x21, y21, x22, y22 = b.position.x, b.position.y, b.position.x + b.size.w, b.position.y + b.size.h
  local allX = {x11,x12,x21,x22}
  local allY = {y11,y12,y21,y22}
  table.sort(allX)
  table.sort(allY)
  local xCol = allX[2]
  local yCol = allY[2]
  local wCol = allX[3] - xCol
  local hCol = allY[3] - yCol
  return {position = {x = xCol, y = yCol}, size = {h = hCol, w = wCol}}
end

function CollisionSystem:isColliding(a,b)
  local x1, y1, w1, h1 = a.position.x, a.position.y, a.size.w, a.size.h
  local x2, y2, w2, h2 = b.position.x, b.position.y, b.size.w, b.size.h
  return x1 < x2+w2 and
    x2 < x1+w1 and
    y1 < y2+h2 and
    y2 < y1+h1
end
---------------------------------------
