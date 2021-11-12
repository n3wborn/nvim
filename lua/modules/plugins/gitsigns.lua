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
        ['n <leader>hn'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
        ['n <leader>hN'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
        ['n <leader>hs'] = ':Gitsigns stage_hunk<CR>',
        ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hu'] = ':Gitsigns undo_stage_hunk<CR>',
        ['n <leader>hS'] = ':Gitsigns stage_buffer<CR>',
        ['n <leader>hr'] = ':Gitsigns reset_hunk<CR>',
        ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hR'] = ':Gitsigns reset_buffer<CR>',
        ['n <leader>hd'] = ':Gitsigns diffthis<CR>',
        ['n <leader>hp'] = ':Gitsigns preview_hunk<CR>',
        ['n <leader>hb'] = ':Gitsigns toggle_current_line_blame<CR>',
        ['n <leader>ha'] = ':Gitsigns get_actions<CR>',
        ['n <leader>ht'] = ':Gitsigns refresh<CR>',
    },
    preview_config = { border = 'rounded' },
})
