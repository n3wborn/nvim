-- https://github.com/lewis6991/gitsigns.nvim
local gitsigns = require('gitsigns')
local u = require('utils')
local bufnr = bufnr or vim.api.nvim_get_current_buf()

local mapping = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', '<leader>hn', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map('n', '<leader>hN', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk)
    map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function()
        gs.diffthis('~')
    end)
end

gitsigns.setup({
    signs = {
        add = { hl = 'GitSignsAdd', text = '▎' },
        change = { hl = 'GitSignsChange', text = '▎' },
        delete = { hl = 'GitSignsDelete', text = '▎' },
        topdelete = { hl = 'GitSignsDelete', text = '▎' },
        changedelete = { hl = 'GitSignsChange', text = '▎' },
    },
    word_diff = true,
    on_attach = mapping(),
    preview_config = { border = 'rounded' },
})
