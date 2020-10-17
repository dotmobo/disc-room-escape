require('const')

function love.conf(t)
    t.window.title = GAME_TITLE
    t.window.width = WIN_WIDTH
    t.window.height = WIN_HEIGHT
    t.console = DEBUG_ENABLE
end
