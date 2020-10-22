local assets = require('assets')

local mt = {}
mt.__index = mt

function mt:update(dt)
  self.toggleCount = self.toggleCount + dt
  if self.toggleCount >= self.toggleDelay then
    self.toggleCount = 0
    self.is_solid = not self.is_solid
  end

end

function mt:draw()
  if self.is_solid then
    assets.qdraw(9, self.x, self.y)
  else
    assets.qdraw(8, self.x, self.y)
  end
end


return {
  new = function(x, y)
    return setmetatable({
      is_toggle_floor = true,
      is_solid = true,
      x = x,
      y = y,
      toggleDelay = 3,
      toggleCount = 0,
      w = GAME_SPRITE_SIZE,
      h = GAME_SPRITE_SIZE
    }, mt)
  end
}
