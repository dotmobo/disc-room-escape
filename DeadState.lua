local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:update(dt)
  if love.keyboard.isDown('return') or (Joystick and Joystick:isGamepadDown('start')) then
    GameState.setCurrent('Play', 1)
  end
end

function mt:draw()
  love.graphics.print('Defeat!\npress [enter] or [start] to restart', 100, 100)
end

-- ignores events:
function mt:trigger()
end

return {
  new = function()
    return setmetatable({ name = 'dead_state' }, mt)
  end
}
