return {
    ---@type LazyPluginSpec
    {
        'sindrets/diffview.nvim',
        cmd = {
            'DiffviewOpen',
            'DiffviewClose',
            'DiffviewRefresh',
            'DiffviewFileHistory',
            'DiffviewFocusFiles',
            'DiffviewToggleFiles',
        },
        keys = {
            {
                '<leader><leader>v',
                function()
                    if next(require('diffview.lib').views) == nil then
                        vim.cmd('DiffviewOpen')
                    else
                        vim.cmd('DiffviewClose')
                    end
                end,
                desc = '󰊢 Diff This',
            },
            {
                '<leader>hD',
                function()
                    local ok, lib = pcall(require, 'diffview.lib')
                    if not ok then
                        vim.notify('diffview.nvim not installed', vim.log.levels.WARN)
                        return
                    end

                    local view = lib.get_current_view()
                    if view then
                        vim.cmd('DiffviewClose')
                        return
                    end

                    local file = vim.api.nvim_buf_get_name(0)
                    if file == '' then
                        vim.cmd('DiffviewOpen')
                    else
                        vim.cmd('DiffviewFileHistory ' .. vim.fn.fnameescape(file))
                    end
                end,
                desc = 'Toggle DiffviewFileHistory on current file',
            },
        },
        opts = {
            keymaps = {
                file_panel = {
                    {
                        'n',
                        'cc',
                        function()
                            vim.ui.input({ prompt = 'Commit message: ' }, function(msg)
                                if not msg then
                                    return
                                end
                                local results = vim.system({ 'git', 'commit', '-m', msg }, { text = true }):wait()

                                if results.code ~= 0 then
                                    vim.notify(
                                        'Commit failed with the message: \n'
                                            .. vim.trim(results.stdout .. '\n' .. results.stderr),
                                        vim.log.levels.ERROR,
                                        { title = 'Commit' }
                                    )
                                else
                                    vim.notify(results.stdout, vim.log.levels.INFO, { title = 'Commit' })
                                end
                            end)
                        end,
                    },
                },
            },
        },
    },
    ---@type LazyPluginSpec
    {
        'NeogitOrg/neogit',
        cmd = { 'Neogit' },
        keys = {
            { '<space>G', ':Neogit<CR>', desc = 'Open Neogit' },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'folke/snacks.nvim',
        },
        opts = {
            graph_style = 'kitty',
            -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
            integrations = {
                telescope = false,
                fzf_lua = false,
                mini_pick = false,
                diffview = true,
                snacks = true,
            },
        },
    },
    ---@type LazyPluginSpec
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
        opts = {
            signs = {
                add = { text = '│ ' },
                change = { text = '│ ' },
                delete = { text = '│ ' },
                topdelete = { text = '│ ' },
                changedelete = { text = '│ ' },
            },
            signs_staged = {
                add = { text = '│ ' },
                change = { text = '│ ' },
                delete = { text = '│ ' },
                topdelete = { text = '│ ' },
                changedelete = { text = '│ ' },
            },
            current_line_blame = true,
            preview_config = {
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
            watch_gitdir = { enabled = true, follow_files = true },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns
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
                map('n', '<leader>hS', gs.stage_buffer, '󰊢 Stage Buffer')
                map('n', '<leader>hu', gs.undo_stage_hunk, '󰊢 Undo Stage Hunk')
                map('n', '<leader>hR', gs.reset_buffer, '󰊢 Reset Buffer')
                map('n', '<leader>hp', gs.preview_hunk_inline, '󰊢 Preview Hunk Inline')
                map('n', '<leader>hb', function()
                    gs.blame_line({ full = true })
                end, '󰊢 Blame Line')
                map('n', '<leader>hB', function()
                    gs.blame()
                end, '󰊢 Blame Buffer')
                map('n', '<leader>tb', function()
                    gs.toogle_current_line_blame()
                end, '󰊢 Toogle Current B')
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', '󰊢 GitSigns Select Hunk')
            end,
        },
    },
}
