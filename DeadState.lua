local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:update(dt)
  if love.keyboard.isDown('return') or (Joystick and Joystick:isGamepadDown('start')) then
    GameState.setCurrent('Play', GAME_LEVEL_START)
  end
end

function mt:draw()
  love.graphics.print({{0,0,0,1}, 'Defeat! Press [enter] or [start] to restart.\n\nThanks for playing Disc Room Escape!'}, 100, 100)
end

-- ignores events:
function mt:trigger()
end

return {
  new = function()
    return setmetatable({ name = 'dead_state' }, mt)
  end
}
