local GameState = require('GameState')
local Level = require('Level')
local World = require('World')

local MAX_LEVEL = 2

local mt = {}
mt.__index = mt

function mt:update(dt)
    for _, item in ipairs(self.world.items) do
        if item.update then
            item:update(dt)
        end
    end
end

function mt:draw()
    for _, item in ipairs(self.world.items) do
        item:draw()
    end
end

function mt:trigger(event, actor, data)
    if event == 'hero:kill' then
        local deadSound = love.audio.newSource(SOUND_DEATH, "static")
        deadSound:play()
        local hero = data
        if not(hero.is_dead) then
            hero.is_dead = true
            GameState.setCurrent('Dead')
        end
    elseif event == 'door:open' then
        local doorSound = love.audio.newSource(SOUND_DOOR, "static")
        doorSound:play()
        if self.level_num < MAX_LEVEL then
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
      state.level = Level.new('map' .. level_num, state)
      state.level_num = level_num
      return state
    end
  }