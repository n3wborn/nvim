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
                desc = 'toogle diffview',
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
        config = function()
            require('diffview')
        end,
    },
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
        'akinsho/git-conflict.nvim',
        version = '*',
        config = true,
        lazy = false, -- contrary to it's doc, we have to set lazy to false  to load the plugin
    },
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
            watch_gitdir = { enabled = true, follow_files = true },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
                end

                map('n', '<leader>hn', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gs.nav_hunk('next', { preview = true })
                    end
                end, 'Next Hunk')
                map('n', '<leader>hN', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gs.nav_hunk('prev', { preview = true })
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
                map('n', '<leader>hd', function()
                    local wins = vim.api.nvim_tabpage_list_wins(0)
                    local diff_win = nil

                    for _, win in ipairs(wins) do
                        local bufnr = vim.api.nvim_win_get_buf(win)
                        local name = vim.api.nvim_buf_get_name(bufnr)
                        if name:match('^gitsigns://') then
                            diff_win = win
                            break
                        end
                    end

                    if diff_win then
                        pcall(vim.api.nvim_win_close, diff_win, false)

                        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                            local bufnr = vim.api.nvim_win_get_buf(win)
                            local name = vim.api.nvim_buf_get_name(bufnr)
                            if not name:match('^gitsigns://') then
                                vim.api.nvim_set_current_win(win)
                                vim.cmd('diffoff')
                                vim.cmd('redraw!')
                                break
                            end
                        end
                    else
                        vim.cmd('Gitsigns diffthis')
                    end
                end, '󰊢 Diff This')
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', '󰊢 GitSigns Select Hunk')
            end,
        },
    },
}
