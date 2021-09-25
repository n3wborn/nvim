-- https://github.com/lewis6991/gitsigns.nvim
local gitsigns = require('gitsigns')

gitsigns.setup({
    signs = {
        add = { hl = 'GitSignsAdd', text = '▎' },
        change = { hl = 'GitSignsChange', text = '▎' },
        delete = { hl = 'GitSignsDelete', text = '▎' },
        topdelete = { hl = 'GitSignsDelete', text = '▎' },
        changedelete = { hl = 'GitSignsChange', text = '▎' },
    },
    keymaps = {
        noremap = true,
        -- jumps
        ['n <leader>hn'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
        ['n <leader>hN'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
        -- stage
        ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
        -- diff
        ['n <leader>hd'] = [[<cmd>lua require"gitsigns".diffthis()<CR>]],
        -- refresh/toggle
        ['n <leader>ht'] = '<cmd>lua require"gitsigns".refresh()<CR>',
    },
})
