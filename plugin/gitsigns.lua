-- https://github.com/lewis6991/gitsigns.nvim

require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '▎', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '▎', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '▎', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '▎', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    numhl = false,
    linehl = false,
    keymaps = {
        noremap = true,

        -- netx/prev_hunk
        ['n <leader>hn'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        ['n <leader>hN'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

        -- stage/unstage hunk/buffer
        ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',

        -- reset hunk/buffer
        ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',

        -- diff
        ['n <leader>hd'] = [[<cmd>lua require"gitsigns".diffthis()<CR>]],

        -- preview
        ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',

        -- blame
        ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
        ['n <leader>hB'] = '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>',

        -- actions
        ['n <leader>ha'] = '<cmd>lua require"gitsigns".get_actions()<CR>',

        -- refresh/toggle(?)
        ['n <leader>ht'] = '<cmd>lua require"gitsigns".refresh()<CR>',

    },
    watch_index = {
        interval = 1000
    },
    current_line_blame = false,
    current_line_blame_position = "right_align",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    use_decoration_api = true,
    use_internal_diff = true,
}

