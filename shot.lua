require('Positioning')

Shot = { speed = 200, size = 5, image = Animation:new(love.graphics.newImage('iexp.png'), 96, 96, 1) }

function Shot:new(owner)
  o = { owner = owner, position = Position:new( owner.front() ) }
  setmetatable(o,self)
  self.__index = self
  return o
end

function Shot:draw(graphics)
  graphics.setColor(255,255,255,255)
  self.image:draw(graphics, self.position.x, self.position.y)
end

function Shot:update(dt)
  self.image:update(dt)
  self.position:translate(dt * self.speed * self.position.facing.x, dt * self.speed * self.position.facing.y)
end

function Shot:informCollision(other, box)
  if type(other.damage) == 'function' then
    other:damage(10)
  end
end
