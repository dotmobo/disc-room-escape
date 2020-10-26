local assets = require('assets')

local mt = {}
mt.__index = mt

function mt:draw()
  assets.qdraw(12, self.x, self.y)
end

return {
  new = function(x, y)
    return setmetatable({
      is_solid = true,
      x = x,
      y = y,
      w = GAME_SPRITE_SIZE,
      h = GAME_SPRITE_SIZE
    }, mt)
  end
}
