local GameState = require('GameState')
Joystick = nil

function love.load()
    local joysticks = love.joystick.getJoysticks()
	Joystick = joysticks[1]
    love.graphics.setDefaultFilter("nearest", "nearest")
    GameState.setCurrent('Start')
    -- music
	local music = love.audio.newSource(GAME_MUSIC_PATH, "static")
	music:setVolume(GAME_MUSIC_VOLUME)
    music:setLooping(true)
    music:play()
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
