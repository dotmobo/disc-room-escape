local mt = {}
mt.__index = mt

function mt:update(dt)
  self.t = self.t + dt
end

function mt:getFrame()
  return self.start + math.floor(self.len * (self.t % self.duration) / self.duration)
end

return {
  new = function(start, len, duration)
    return setmetatable({
      t = 0,
      start = start,
      len = len,
      duration = duration,
    }, mt)
  end
}
