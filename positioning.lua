Directions = {
  N = { x = 0,  y = -1 },
  S = { x = 0,  y = 1  },
  E = { x = 1 , y = 0  },
  W = { x = -1, y = 0 }
}

Position = { x = 0, y = 0, facing = Directions.N }

function Directions:which(ox,oy,nx,ny)
  if oy == ny and ox == nx then return nil end
  if oy ~= ny then
    if oy > ny then return self['N'] else return self['S'] end
  else
    if ox > nx then return self['W'] else return self['E'] end
  end
end

function Position:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end

function Position:translate(dx, dy)
  local ox = self.x
  local oy = self.y
  self.x = self.x + dx
  self.y = self.y + dy
  local newFacing = Directions:which(ox,oy,self.x,self.y)
  if newFacing then
    print('changing'..newFacing.x..newFacing.y)
    self.facing = newFacing
  end
end
