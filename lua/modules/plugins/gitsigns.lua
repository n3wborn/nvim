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
    word_diff = true,
    keymaps = {
        noremap = true,
        ['n <leader>hn'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" },
        ['n <leader>hN'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" },
        ['n <leader>hs'] = '<cmd>Gitsigns stage_hunk<CR>',
        ['v <leader>hs'] = '<cmd>Gitsigns stage_hunk<CR>',
        ['n <leader>hu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
        ['n <leader>hS'] = '<cmd>Gitsigns stage_buffer<CR>',
        ['n <leader>hr'] = '<cmd>Gitsigns reset_hunk<CR>',
        ['v <leader>hr'] = '<cmd>Gitsigns reset_hunk<CR>',
        ['n <leader>hR'] = '<cmd>Gitsigns reset_buffer<CR>',
        ['n <leader>hd'] = '<cmd>Gitsigns diffthis<CR>',
        ['n <leader>hp'] = '<cmd>Gitsigns preview_hunk<CR>',
        ['n <leader>hb'] = '<cmd>Gitsigns toggle_current_line_blame<CR>',
        ['n <leader>ht'] = '<cmd>Gitsigns refresh<CR>',
    },
    preview_config = { border = 'rounded' },
})
