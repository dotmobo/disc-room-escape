local assets = require('assets')
local GameState = require('GameState')
local Animation = require('Animation')

local mt = {}
mt.__index = mt



function mt:update(dt)
    -- go to spawn when player dying
    if self.is_dead then
        GameState.getCurrent().world:move(self, self.ox, self.oy, 'is_solid')
        self.is_dead = false
    end

    local dx, dy = 0, 0

    self:setAnim('idle')

    if (love.keyboard.isDown('up') or (Joystick and (Joystick:isGamepadDown('a')))) then
        -- init jump
        if self:canJump() then
            self.vy = HERO_JUMP_SPEED
            self.is_jumping = true
            local jumpSound = love.audio.newSource(SOUND_JUMP, "static")
            jumpSound:play()
        -- during the jump
        elseif self.is_jumping == true then
            -- reduce the gravity for smooth jump
            if self.vy < 0 then
                self.vy = self.vy - HERO_JUMP_GRAVITY * dt
            end
        end
    end
    if love.keyboard.isDown('left') or (Joystick and (Joystick:isGamepadDown('dpleft') or Joystick:getGamepadAxis('leftx') <= -0.25)) then
        self:setAnim('run')
        self.last_direction = -1
        -- acceleration system
        self.vx = self.vx + (-self.speed * self.acceleration * dt)
        if self.vx < -self.speed then self.vx = -self.speed end
        -- dx = dx - dt * self.speed
    elseif love.keyboard.isDown('right') or (Joystick and (Joystick:isGamepadDown('dpright') or Joystick:getGamepadAxis('leftx') >= 0.25)) then
        self:setAnim('run')
        self.last_direction = 1
        -- acceleration system
        self.vx = self.vx + (self.speed * self.acceleration * dt)
        if self.vx > self.speed then self.vx = self.speed end
        -- dx = dx + dt * self.speed
    else
        -- deceleration system
        if self.vx < 0 then
            self.vx = self.vx + (self.speed * self.deceleration * dt)
            if self.vx > 0 then self.vx = 0 end
        elseif self.vx > 0 then
            self.vx = self.vx + (-self.speed * self.deceleration * dt)
            if self.vx < 0 then self.vx = 0 end
        end
        -- self.vx = 0
    end
    dx = dx + self.vx * dt
    GameState.getCurrent().world:move(self, self.x + dx, self.y + self.vy, 'is_solid')
    -- gravity
    if self:isGrounded() then
        self.vy = 0
        self.is_jumping = false
        self.ungroundedTime = 0
    else
        self:setAnim('jump')
        self.vy = math.min(self.vy + HERO_GRAVITY * dt, HERO_MAX_VELOCITY)
        self.ungroundedTime = self.ungroundedTime + dt
    end
    -- on verifie en continue sur le joueur touche un item touchable, et si oui lancer l'evenement de l item
    local touchables = GameState.getCurrent().world:find(self, 'is_touchable')
    for _, touchable in ipairs(touchables) do
        touchable:onTouch(self)
    end
    -- update animation
    self.current_anim:update(dt)
end

function mt:draw()
    if self.last_direction == -1 then
        -- 3 last args here are: rotation, scale_x, scale_y
        assets.qdraw(self.current_anim:getFrame(), self.x + 16 - 2, self.y + 1, 0, -1, 1)
    else
        assets.qdraw(self.current_anim:getFrame(), self.x - 2, self.y + 1)
    end
end

function mt:setAnim(name)
    self.current_anim = self.anims[name]
end

function mt:isGrounded()
    return GameState.getCurrent().world:check({x = self.x, y = self.y+self.h, w = self.w, h = 1}, 'is_solid')
end

function mt:canJump()
    -- can jump if grounded, if not jump currently and if jump forgiveness authorized
    return self:isGrounded() or (self.ungroundedTime > 0 and self.ungroundedTime <= HERO_JUMP_FORGIVENESS) and not(self.is_jumping)
end

return {
    new = function(x, y)
        local h = setmetatable({
            is_hero = true,
            ox = x, oy = y,
            x = x, y = y,
            w = GAME_SPRITE_SIZE - 4, h = GAME_SPRITE_SIZE,
            vy = 0,
            speed = HERO_MAX_SPEED,
            acceleration = HERO_ACCELERATION,
            deceleration = HERO_DECELERATION,
            vx = 0,
            is_jumping = false,
            ungroundedTime = 0,
            anims = {
                idle = Animation.new(1, 2, 0.5),
                run = Animation.new(3, 2, 0.6),
                jump = Animation.new(5, 1, 0.5)
              },
        }, mt)
        h:setAnim('idle')
        return h
    end
}
