return {
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
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPre',
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
        -- config = function()
        --     require('gitsigns').setup()
        -- end,
    },
}
