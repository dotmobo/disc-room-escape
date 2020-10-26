local assets = require('assets')
local const = require('const')
local GameState = require('GameState')
local Animation = require('Animation')

local mt = {}
mt.__index = mt

function mt:draw()
  if self.dir == -1 then
    assets.qdraw(self.current_anim:getFrame(), self.x + 16, self.y, 0, -1, 1)
  else
    assets.qdraw(self.current_anim:getFrame(), self.x, self.y)
  end
end

function mt:update(dt)
  self.current_anim:update(dt)

  GameState.getCurrent().world:move(self, self.x+self.dir*self.speed*dt, self.y, 'is_solid')

  local is_obstacle_ahead = GameState.getCurrent().world:check({
    x = self.x + self.w/2 + self.w*2/3  * self.dir,
    y = self.y + self.h/2,
    w = 2,
    h = 2
  }, 'is_solid')

  local is_floor_ahead = GameState.getCurrent().world:check({
    x = self.x + self.w/2 + self.w*2/3  * self.dir,
    y = self.y + self.h + 1,
    w = 2,
    h = 2
  }, 'all')

  if is_obstacle_ahead or not is_floor_ahead then
    self:turnBack()
  end
end

function mt:turnBack()
  self.dir = self.dir * -1
end

function mt:onTouch(other)
  if other.is_hero then
    self:setAnim('bloody')
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
      dir = 1,
      speed = 60,
      anims = {
        idle = Animation.new(25, 2, 0.2),
        bloody = Animation.new(27, 2, 0.2),
      },
    }, mt)
    d:setAnim('idle')
    return d
  end
}
