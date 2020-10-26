local assets = require('assets')

local mt = {}
mt.__index = mt

function mt:draw()
  if (self.x / GAME_SPRITE_SIZE % 2 == 0) then
    assets.qdraw(10, self.x, self.y)
  else
    assets.qdraw(11, self.x, self.y)
  end
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
