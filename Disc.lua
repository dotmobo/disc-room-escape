local assets = require('assets')
local GameState = require('GameState')
local Animation = require('Animation')

local mt = {}
mt.__index = mt

function mt:update(dt)
  -- update animation
  self.current_anim:update(dt)
end

function mt:draw()
  assets.qdraw(self.current_anim:getFrame(), self.x, self.y)
end

function mt:onTouch(other)
    if other.is_hero then
        GameState.getCurrent():trigger('hero:kill', self, other)
    end
end

function mt:setAnim(name)
  self.current_anim = self.anims[name]
end

return {
  new = function(x, y)
    local d = setmetatable({
      is_touchable = true,
      x = x,
      y = y,
      w = GAME_SPRITE_SIZE,
      h = GAME_SPRITE_SIZE,
      anims = {
        idle = Animation.new(15, 2, 0.2),
      },
    }, mt)
    d:setAnim('idle')
    return d;
  end
}
