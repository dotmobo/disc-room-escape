local assets = require('assets')
local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:draw()
  assets.qdraw(15, self.x, self.y)
end

function mt:onTouch(other)
    if other.is_hero then
        GameState.getCurrent():trigger('hero:kill', self, other)
    end
end

return {
  new = function(x, y)
    return setmetatable({
      is_touchable = true,
      x = x,
      y = y,
      w = GAME_SPRITE_SIZE,
      h = GAME_SPRITE_SIZE
    }, mt)
  end
}
