require('Positioning')

Shot = { speed = 200, size = 5 }

function Shot:new(owner)
  o = { owner = owner, position = Position:new( owner.front() ) }
  setmetatable(o,self)
  self.__index = self
  return o
end

function Shot:draw(graphics)
  graphics.setColor(255,0,0,255)
  graphics.circle("fill", self.position.x, self.position.y, self.size, 5)
end

function Shot:update(dt)
  self.position:translate(dt * self.speed * self.position.facing.x, dt * self.speed * self.position.facing.y)
end

function Shot:informCollision(other, box)
  if type(other.damage) == 'function' then
    other:damage(10)
  end
end
