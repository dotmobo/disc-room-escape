local GameState = require('GameState')
Joystick = nil

function love.load()
    local joysticks = love.joystick.getJoysticks()
	Joystick = joysticks[1]
    love.graphics.setDefaultFilter("nearest", "nearest")
    GameState.setCurrent('Play', 1)
end

function love.update(dt)
    GameState.getCurrent():update(dt)
    GameState.update()
end

function love.draw()
    love.graphics.scale(GAME_SCALE, GAME_SCALE)
    love.graphics.setBackgroundColor( 104/255, 124/255, 133/255 )
    GameState.getCurrent():draw()
end
