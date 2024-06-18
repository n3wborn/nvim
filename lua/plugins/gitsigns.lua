return {
    'lewis6991/gitsigns.nvim',
    -- event = 'BufReadPre',
    config = function()
        require('gitsigns').setup({
            signs = {
                add = { text = '│ ' },
                change = { text = '│ ' },
                delete = { text = '│ ' },
                topdelete = { text = '│ ' },
                changedelete = { text = '│ ' },
            },
            signs_staged = {
                add = { text = '│ ' },
                change = { text = '│ ' },
                delete = { text = '│ ' },
                topdelete = { text = '│ ' },
                changedelete = { text = '│ ' },
            },
            auto_attach = true,
            current_line_blame = true,
            preview_config = {
                border = _G.global.float_border_opts.border,
                style = 'minimal',
            },
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align
                delay = 999,
                ignore_whitespace = false,
                virt_text_priority = 99,
            },
        })
    end,
}
