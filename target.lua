require('Positioning')

Target = { hp = 10, position = Position:new(), size = 25, image = love.graphics.newImage('iTarget.png') }

function Target:new(x,y)
  self.position = Position:new{x = x, y = y}
  self.__index = self
  return self
end

function Target:isDestroyed()
  return self.hp <= 0
end

function Target:damage(dmg)
  self.hp = self.hp - dmg
end

function Target:draw(graphics)
  if self:isDestroyed() then return end
  graphics.setColor(255,255,255,255)
  graphics.draw( self.image, self.position.x, self.position.y )
end

function Target:update(dt)
end

function Target:informCollision(other,box)
end
