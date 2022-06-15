-- https://github.com/lewis6991/gitsigns.nvim
local gitsigns = require('gitsigns')
local buf = bufnr or vim.api.nvim_get_current_buf()

local mapping = function(buf)
    local u = require('utils')
    local gs = package.loaded.gitsigns

    -- Navigation
    if gs.get_hunks() then
        u.map('n', '<leader>hn', function()
            gs.next_hunk({ preview = true, navigation_message = false })
        end)
        u.map('n', '<leader>hN', function()
            gs.prev_hunk({ preview = true, navigation_message = false })
        end)
    end

    -- Actions
    u.map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk)
    u.map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk)
    u.map('n', '<leader>hS', gs.stage_buffer)
    u.map('n', '<leader>hu', gs.undo_stage_hunk)
    u.map('n', '<leader>hR', gs.reset_buffer)
    u.map('n', '<leader>hp', gs.preview_hunk)
    u.map('n', '<leader>hb', function()
        gs.blame_line({ full = true })
    end)
    u.map('n', '<leader>tb', gs.toggle_current_line_blame)
    u.map('n', '<leader>hd', gs.diffthis)
    u.map('n', '<leader>hD', function()
        gs.diffthis('~')
    end)
end

gitsigns.setup({
    signs = {
        add = { hl = 'GitSignsAdd', text = '│ ' },
        change = { hl = 'GitSignsChange', text = '│ ' },
        delete = { hl = 'GitSignsDelete', text = '│ ' },
        topdelete = { hl = 'GitSignsDelete', text = '│ ' },
        changedelete = { hl = 'GitSignsChange', text = '│ ' },
    },
    word_diff = true,
    on_attach = mapping(buf),
    preview_config = { border = 'rounded' },
})
