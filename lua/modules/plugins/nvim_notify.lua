-- https://github.com/rcarriga/nvim-notify
local config = {
    timeout = 2000,
    fps = 20,
    background_colour = '#000000',
    render = 'compact',
    stages = 'fade_in_slide_out',
    max_height = function()
        return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
        return math.floor(vim.o.columns * 0.75)
    end,
}
require('notify').setup(config)
vim.notify = require('notify')
