local TILES_TYPES = {
    [9] = require('Hero'),
    [1] = require('Wall'),
    [2] = require('Floor'),
    [4] = require('Door'),
    [5] = require('Disc'),
    [8] = require('Enemy')
}

local mt = {}
mt.__index = mt

function mt:draw()
    for _, tile in ipairs(self.tiles) do
        love.graphics.rectangle('line', tile.x, tile.y, tile.w, tile.h)
    end
end

return {
    new = function(lvl_name, game_state)
        local lvl = setmetatable({ columns = 25, tiles = {} }, mt)

        lvl.data = require(lvl_name)

        for i, v in ipairs(lvl.data) do
            local x, y = (i-1) % lvl.columns * GAME_SPRITE_SIZE, math.floor((i-1) / lvl.columns) * GAME_SPRITE_SIZE

            if TILES_TYPES[v] then
                game_state.world:add( TILES_TYPES[v].new(x, y, game_state) )
            end
        end

        return lvl
    end
}