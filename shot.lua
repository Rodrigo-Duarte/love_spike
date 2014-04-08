require('Positioning')
require('anim')
Shot = { speed = 200, size = 5, shotsFired = {}, ttl = 2 }

function Shot:new(owner)
  Shot.shotsFired[owner] = Shot.shotsFired[owner] or {}
  if #Shot.shotsFired[owner] > 0 then return Shot.shotsFired[owner][1] end
  o = { owner = owner, position = Position:new( owner.front() ), image = Animation:new(love.graphics.newImage('iexp.png'), 96, 96, 1) }
  setmetatable(o,self)
  self.__index = self
  table.insert(Shot.shotsFired[owner], o)
  table.insert(artifacts, o)
  return o
end

function Shot:draw(graphics)
  graphics.setColor(255,255,255,255)
  self.image:draw(graphics, self.position.x, self.position.y)
end

function Shot:update(dt)
  self.image:update(dt)
  self.position:translate(dt * self.speed * self.position.facing.x, dt * self.speed * self.position.facing.y)
  self.ttl = self.ttl - dt
  if self.ttl <= 0 then
    remove(Shot.shotsFired[self.owner], self)
    remove(artifacts, self)
  end
end

function Shot:informCollision(other, box)
  if type(other.damage) == 'function' then
    other:damage(10)
    table.remove(Shot.shotsFired[self.owner], 1)
  end
end
