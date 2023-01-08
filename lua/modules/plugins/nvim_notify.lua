-- https://github.com/rcarriga/nvim-notify
local config = {
    timeout = 3000,
    fps = 20,
    background_colour = '#000000',
    render = 'default',
    stages = 'fade_in_slide_out',
    max_height = function()
        return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
        return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
        local buf = vim.api.nvim_win_get_buf(win)
        vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
    end,
}
require('notify').setup(config)
vim.notify = require('notify')
