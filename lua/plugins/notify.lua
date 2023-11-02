return {
    'rcarriga/nvim-notify',
    keys = {
        {
            '<leader>un',
            function()
                require('notify').dismiss({ silent = true, pending = true })
            end,
            desc = 'Delete all Notifications',
        },
    },
    opts = {
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
        on_open = function(win)
            vim.api.nvim_set_option_value('filetype', 'markdown', { buf = vim.api.nvim_win_get_buf(win) })
        end,
    },
}
