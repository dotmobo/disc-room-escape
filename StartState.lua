local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:update(dt)
  if love.keyboard.isDown('return') or (Joystick and Joystick:isGamepadDown('start')) then
    GameState.setCurrent('Play', GAME_LEVEL_START)
    local doorSound = love.audio.newSource(SOUND_DOOR, "static")
    doorSound:play()
  end
end

function mt:draw()
  love.graphics.setNewFont(12)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setBackgroundColor( 104/255, 124/255, 133/255 )
  love.graphics.draw(self.img, 70, 0, 0, 0.4, 0.4)
  love.graphics.print({{0,0,0,1}, 'Press [enter] or [start] to start the game !'}, 75, 220)
end

-- ignores events:
function mt:trigger()
end

return {
  new = function()
    return setmetatable({ name = 'start_state',  img = love.graphics.newImage("assets/cover.png") }, mt)
  end
}
