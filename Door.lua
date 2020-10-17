local assets = require('assets')
local const = require('const')
local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:update(dt)
  self.touches_hero = GameState.getCurrent().world:check(self, 'is_hero')
end

function mt:draw()
  assets.qdraw(7, self.x, self.y)
  if self.touches_hero then
    GameState.getCurrent():trigger('door:open')
  end
end


return {
  new = function(x, y, game_state)
    return setmetatable({
      is_door = true,
      x = x,
      y = y,
      w = GAME_SPRITE_SIZE,
      h = GAME_SPRITE_SIZE,
    }, mt)
  end
}
