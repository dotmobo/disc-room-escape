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
end

function mt:draw()
    for _, item in ipairs(self.world.items) do
        item:draw()
    end
end

function mt:trigger(event, actor, data)
    if event == 'hero:kill' then
        local hero = data
        if not(hero.is_dead) then
            hero.is_dead = true
            GameState.setCurrent('Dead')
        end
    end
end

return {
    new = function()
      local state = setmetatable({ name = 'play_state' }, mt)
      state.world = World.new()
      state.level = Level.new('map1', state)

      return state
    end
  }