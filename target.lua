require('Positioning')

Target = { hp = 10, position = Position:new(), size = 25 }

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
  graphics.setColor(0,200,0,200)
  graphics.circle("fill", self.position.x, self.position.y, self.size, 10)
end

function Target:update(dt)
end

function Target:informCollision(other,box)
end
