love = love or {}

controls = {
  keyPressed = function(key)
    controls[key] = 1
  end,
  keyReleased = function(key)
    controls[key] = 0
  end,

  up = 0,
  down = 0,
  left = 0,
  right = 0
}

function love.keypressed(key)
	controls[key] = 1
end

function love.keyreleased(key)
	controls[key] = 0
end
