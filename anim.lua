Animation = {}

function Animation:new(image, w, h, t)
  local o = { image = image, w = w, h = h, t = t, ct = 0 }
  setmetatable(o,self)
  self.__index = self
  return o
end

function Animation:update(dt)
  self.ct = self.ct + dt
end

function Animation:draw(graphics,x,y)
  local tw, th = self.image:getDimensions()
  local frames = tw/self.w
  local tx = math.ceil(self.ct/self.t)%frames * self.w
  local quad = love.graphics.newQuad(tx,0,self.w,self.h,tw,th)
  love.graphics.draw( self.image, quad, x, y)
end
