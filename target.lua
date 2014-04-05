require('Positioning')

Target = { hp = 10, position = Position:new() }

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
  graphics.setColor(0,200,0,200)
  graphics.circle("fill", self.position.x, self.position.y, 25, 10)
end

function Target:update(dt)
end
