-- https://github.com/lewis6991/gitsigns.nvim
local u = require('utils')
local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')

if not gitsigns_ok then
    u.notif('Plugins :', 'Something went wrong with gitsigns', vim.log.levels.WARN)
    return
else
    local jump_hunk_opts = { preview = true, navigation_message = 'f' }

    local mappings = function(bufnr)
        local u = require('utils')
        local gs = package.loaded.gitsigns
        bufnr = bufnr or vim.api.nvim_get_current_buf()

        if vim.api.nvim_buf_get_name(bufnr) then
            -- jumps
            u.map('n', '<leader>hn', function()
                gs.next_hunk(jump_hunk_opts)
            end)
            u.map('n', '<leader>hN', function()
                gs.prev_hunk(jump_hunk_opts)
            end)

            -- actions
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
        on_attach = mappings(),
        preview_config = { border = 'rounded' },
    })
end
