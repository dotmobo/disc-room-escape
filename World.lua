local mt = {}
mt.__index = mt

function mt:add(item)
  self.items[#self.items + 1] = item
end

local function checkCollision(a, b)
  return a.x < b.x + b.w and
         a.x + a.w > b.x and
         a.y < b.y + b.h and
         a.h + a.y > b.y
end

function mt:check(item, param)
  for _, other in ipairs(self.items) do
    if other ~= item and checkCollision(item, other) and (param == 'all' or other[param]) then
      return true
    end
  end
  return false
end

function mt:find(item, param)
    local t = {}
    for _, other in ipairs(self.items) do
        if other ~= item and (item == 'all' or checkCollision(item, other)) and (param == 'all' or other[param]) then
            t[#t+1] = other
        end
    end
    return t
end

function mt:move(item, new_x, new_y, param)
  local prev_x, prev_y = item.x, item.y

  item.x = new_x
  for _, other in ipairs(self.items) do
    if other ~= item and checkCollision(item, other) and (param == 'all' or other[param]) then
      -- fix some glitch with collision
      if new_x > prev_x then
        item.x = other.x - item.w -- fix to be pixel perfect
        item.vx = 0 -- reset velocity during collision to move faster after
      else
        item.x = other.x + other.w -- fix to be pixel perfect
        item.vx = 0 -- reset velocity during collision to move faster after
      end
      break
    end
  end

  item.y = new_y
  for _, other in ipairs(self.items) do
    if other ~= item and checkCollision(item, other) and (param == 'all' or other[param]) then
      if new_y > prev_y then
        item.y = other.y - item.h
      else
        item.y = other.y + other.h
      end
      break
    end
  end
end


return {
  new = function()
    return setmetatable({ items = {} }, mt)
  end
}
