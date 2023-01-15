local M = {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
}

function M.config()
    if not package.loaded.trouble then
        package.preload.trouble = function()
            return true
        end
    end
    require('gitsigns').setup({
        signs = {
            add = { text = '│ ' },
            change = { text = '│ ' },
            delete = { text = '│ ' },
            topdelete = { text = '│ ' },
            changedelete = { text = '│ ' },
        },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                if type(opts) == 'string' then
                    opts = { desc = opts }
                end
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            local jump_hunk_opts = { preview = true, navigation_message = 'f' }
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
        end,
    })
    package.loaded.trouble = nil
    package.preload.trouble = nil
end

return M
