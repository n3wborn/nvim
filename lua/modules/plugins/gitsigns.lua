-- https://github.com/lewis6991/gitsigns.nvim
local u = require('utils')
local gitsigns_ok, gs = pcall(require, 'gitsigns')

if not gitsigns_ok then
    u.notif('Plugins :', 'Something went wrong with gitsigns', vim.log.levels.WARN)
    return
else
    local jump_hunk_opts = { preview = true, navigation_message = 'f' }

    local mappings = function(bufnr)
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', '<leader>hn', function()
            if vim.wo.diff then
                return ']c'
            end
            vim.schedule(function()
                gs.next_hunk(jump_hunk_opts)
            end)
            return '<Ignore>'
        end, {
            expr = true,
            desc = 'next hunk',
        })

        map('n', '<leader>hN', function()
            if vim.wo.diff then
                return '[c'
            end
            vim.schedule(function()
                gs.prev_hunk(jump_hunk_opts)
            end)
            return '<Ignore>'
        end, {
            expr = true,
            desc = 'previous hunk',
        })

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk)
        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk)
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function()
            gs.blame_line({ full = true })
        end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function()
            gs.diffthis('~')
        end)
    end

    gs.setup({
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
