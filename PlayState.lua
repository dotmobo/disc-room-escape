local GameState = require('GameState')
local Level = require('Level')
local World = require('World')

local mt = {}
mt.__index = mt

function mt:update(dt)
    for _, item in ipairs(self.world.items) do
        if item.update then
            item:update(dt)
        end
    end
    -- Game lost if timer 0
    if self.timer <= 0 then
        GameState.setCurrent('Dead')
    end
    self.timer = self.timer - dt
end

function mt:draw()
    for _, item in ipairs(self.world.items) do
        item:draw()
    end
    love.graphics.setNewFont(10)
    love.graphics.print({{0,0,0,0.7}, 'ROOM ' .. self.level_num .. '/' .. GAME_LEVEL_MAX .. ' - TIME LEFT ' .. math.floor(self.timer) ..'s'}, 16, 16)
end

function mt:trigger(event, actor, data)
    if event == 'hero:kill' then
        local discSound = love.audio.newSource(SOUND_DISC, "static")
        discSound:play()
        local deadSound = love.audio.newSource(SOUND_DEATH, "static")
        deadSound:play()
        local hero = data
        if not(hero.is_dead) then
            hero.is_dead = true
            -- GameState.setCurrent('Dead')
        end
    elseif event == 'door:open' then
        local doorSound = love.audio.newSource(SOUND_DOOR, "static")
        doorSound:play()
        if self.level_num < GAME_LEVEL_MAX then
          GameState.setCurrent('Play', self.level_num + 1)
        else
          GameState.setCurrent('Win')
        end
    end
end

return {
    new = function(level_num)
      local state = setmetatable({ name = 'play_state' }, mt)
      state.world = World.new()
      state.level = Level.new('maps/map' .. level_num, state)
      state.level_num = level_num
      state.timer = 20 -- 20 secondes
      return state
    end
  }