local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:update(dt)
  if love.keyboard.isDown('return') then
    GameState.setCurrent('Play', 1)
  end
end

function mt:draw()
  love.graphics.print('Victory!\npress [enter] to restart', 100, 100)
end

function mt:trigger()
end

return {
  new = function()
    return setmetatable({ name = 'win_state' }, mt)
  end
}
