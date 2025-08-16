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
        },
        config = function()
            require('diffview')
        end,
    },
    ---@type LazyPluginSpec
    {
        'akinsho/git-conflict.nvim',
        event = 'BufReadPre',
        opts = {
            disable_diagnostics = true,
            --[[
            MAPPINGS

            co — choose ours
            ct — choose theirs
            cb — choose both
            c0 — choose none
            ]x — move to previous conflict
            [x — move to next conflict
        ]]
        },
    },
    ---@type LazyPluginSpec
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
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
            auto_attach = true,
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
        },
        keys = {
            {
                '<leader>hn',
                function()
                    require('gitsigns').nav_hunk('next', { preview = true })
                end,
                desc = 'Gitsigns next hunk',
            },
            {
                '<leader>hN',
                function()
                    require('gitsigns').nav_hunk('prev', { preview = true })
                end,
            },
            {
                mode = 'n',
                '<leader>hs',
                ':Gitsigns stage_hunk<CR>',
            },
            {
                mode = { 'x', 'v' },
                '<leader>hs',
                function()
                    require('gitsigns').stage_hunk()
                end,
            },
            {
                mode = 'n',
                '<leader>hS',
                ':Gitsigns stage_buffer<CR>',
            },
            {
                mode = 'n',
                '<leader>hu',
                ':Gitsigns stage_hunk<CR>',
            },
            {
                mode = { 'x', 'v' },
                '<leader>hr',
                function()
                    require('gitsigns').reset_hunk()
                end,
            },
            {
                mode = 'n',
                '<leader>hR',
                ':Gitsigns reset_buffer<CR>',
            },

            {
                mode = 'n',
                '<leader>hp',
                ':Gitsigns preview_hunk<CR>',
            },
            {
                '<leader>hB',
                ':Gitsigns blame <CR>',
            },
            {
                '<leader>hb',
                ':Gitsigns blame_line<CR>',
            },
            {
                '<leader>tb',
                ':Gitsigns toggle_current_line_blame<CR>',
            },
            {
                mode = 'n',
                '<leader>hd',
                ':Gitsigns diffthis<CR>',
            },
            {
                mode = 'n',
                '<leader>hD',
                ':Gitsigns diffthis ~<CR>',
            },
            {
                mode = 'n',
                '<leader>td',
                ':Gitsigns preview_hunk_inline<CR>',
            },
        },
    },
}
