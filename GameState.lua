local GameState = {}

function GameState.setCurrent(state_name)
  GameState.next_current = require(state_name .. 'State').new()
  if not GameState.current then
    GameState.update()
  end
end

function GameState.getCurrent()
  return GameState.current
end

function GameState.update()
  GameState.current = GameState.next_current
end

return GameState
