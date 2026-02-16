---@type LazyPluginSpec
return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    ---@diagnostic disable: missing-fields
    ---@type Gitsigns.Config
    opts = {
        signs = {
            add = { text = '│ ' },
            change = { text = '│ ' },
            delete = { text = '│ ' },
            topdelete = { text = '│ ' },
            changedelete = { text = '│ ' },
            untracked = { text = '│ ' },
        },
        signs_staged = {
            add = { text = '│ ' },
            change = { text = '│ ' },
            delete = { text = '│ ' },
            topdelete = { text = '│ ' },
            changedelete = { text = '│ ' },
        },
        current_line_blame = true,
        attach_to_untracked = true,
        preview_config = {
            border = 'rounded',
            style = 'minimal',
        },
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align
            delay = 999,
            ignore_whitespace = false,
            virt_text_priority = 99,
        },
        gh = true,
        on_attach = function(buffer)
            local gs = require('gitsigns')
            local nav_hunk_opts = { preview = true, greedy = false, target = 'all' }

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
            end

            map('n', '<leader>hn', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gs.nav_hunk('next', nav_hunk_opts)
                end
            end, 'Next Hunk')
            map('n', '<leader>hN', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gs.nav_hunk('prev', nav_hunk_opts)
                end
            end, 'Prev Hunk')
            map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', '󰊢 (Un)Stage Hunk')
            map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', '󰊢 Reset Hunk')
            map('n', '<leader>hS', gs.stage_buffer, '󰊢 Stage/Unstage Buffer')
            map('n', '<leader>hR', gs.reset_buffer, '󰊢 Reset Buffer')
            map('n', '<leader>hp', gs.preview_hunk_inline, '󰊢 Preview Hunk Inline')
            map('n', '<leader>hb', function()
                gs.blame_line({ full = true })
            end, '󰊢 Blame Line')
            map('n', '<leader>hB', function()
                gs.blame()
            end, '󰊢 Blame Buffer')
            map('n', '<leader>tb', gs.toggle_current_line_blame, '󰊢 Toogle Current Line Blame')
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', '󰊢 GitSigns Select Hunk')
        end,
    },
}
