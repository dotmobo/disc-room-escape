local mt = {}
mt.__index = mt

function mt:update(dt)
    self.psystem:update(dt)
end

function mt:draw()
    love.graphics.draw(self.psystem, self.x, self.y)
end


return {
  new = function(img, number, x, y)
    local p = setmetatable({
        psystem = love.graphics.newParticleSystem(img, number),
        x = x,
        y = y
    }, mt)
    p.psystem:setParticleLifetime(0.5, 3)
    p.psystem:setEmissionRate(128)
    p.psystem:setEmitterLifetime(0.5)
    p.psystem:setSizeVariation(1)
    p.psystem:setLinearAcceleration(-100, -100, 100, 100)
    p.psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0)
    return p
  end
}
