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
        version = '*',
        config = true,
        lazy = false, -- contrary to it's doc, we have to set lazy to false  to load the plugin
    },
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
            ---@diagnostic disable: param-type-mismatch
            {
                '<leader>hn',
                function()
                    require('gitsigns').nav_hunk('next', { preview = true })
                end,
                desc = '󰊢 Next hunk',
            },
            {
                '<leader>hN',
                function()
                    require('gitsigns').nav_hunk('prev', { preview = true })
                end,
                desc = '󰊢 Previous hunk',
            },
            {
                '<leader>hs',
                '<cmd>Gitsigns stage_hunk<CR>',
                desc = '󰊢 (Un-)Stage hunk',
            },
            {
                mode = { 'x', 'v' },
                '<leader>hs',
                function()
                    require('gitsigns').stage_hunk()
                end,
            },
            {
                '<leader>hS',
                ':Gitsigns stage_buffer<CR>',
            },
            {
                mode = 'n',
                '<leader>hu',
                ':Gitsigns stage_hunk<CR>',
            },
            {
                mode = { 'n', 'v' },
                '<leader>hr',
                function()
                    require('gitsigns').reset_hunk()
                end,
            },
            {
                '<leader>hR',
                '<cmd>Gitsigns reset_buffer<CR>',
            },

            {
                '<leader>hp',
                '<cmd>Gitsigns preview_hunk<CR>',
            },
            {
                '<leader>hB',
                '<cmd>Gitsigns blame<CR>',
            },
            {
                '<leader>hb',
                '<cmd>Gitsigns blame_line<CR>',
            },
            {
                '<leader>tb',
                '<cmd>Gitsigns toogle_current_line_blame<CR>',
            },
            {
                '<leader>hd',
                '<cmd>Gitsigns diffthis<CR>',
            },
            {
                '<leader>hD',
                '<cmd>Gitsigns diffthis ~<CR>',
            },
            {
                '<leader>td',
                '<cmd>Gitsigns preview_hunk_inline<CR>',
            },
        },
        config = function(_, opts)
            require('gitsigns').setup(opts)
        end,
    },
}
