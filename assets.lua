local assets, quads, tex, battlemage = {}, {}, nil, nil

function assets.qdraw(id, x, y, r, sx, sy)
  if not tex then
    tex = love.graphics.newImage('assets/tiles.png')
    for y = 0, tex:getHeight()-1, GAME_SPRITE_SIZE do
      for x = 0, tex:getWidth()-1, GAME_SPRITE_SIZE do
        quads[#quads+1] = love.graphics.newQuad(x, y, GAME_SPRITE_SIZE, GAME_SPRITE_SIZE, tex:getDimensions())
      end
    end
  end

  love.graphics.draw(tex, quads[id], x, y, r, sx, sy)
end

return assets
