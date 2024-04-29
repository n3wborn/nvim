return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    keys = {
        { '<space>F', '<cmd>FzfLua<cr>', desc = 'open FzfLua' },
        {
            '<leader>ff',
            function()
                require('fzf-lua').files()
            end,
            desc = 'Find File',
        },
        {
            '<leader>fF²',
            function()
                require('fzf-lua').file({})
            end,
            desc = 'Find File',
        },
        {
            '<leader>sp',
            function()
                require('fzf-lua').grep_project()
            end,
            desc = 'Search Project',
        },
        {
            '<leader>sd',
            function()
                require('fzf-lua').grep_cword()
            end,
            desc = 'Grep Current Word',
        },
        {
            '<leader>o',
            function()
                require('fzf-lua').oldfiles()
            end,
            desc = 'Old files opened',
        },
        {
            '<leader>b',
            function()
                require('fzf-lua').buffers()
            end,
            desc = 'Find Buffers',
        },
        {
            '<leader>gc',
            function()
                require('fzf-lua').git_commits()
            end,
            desc = 'Git Commits',
        },
        {
            '<leader>gp',
            function()
                require('fzf-lua').git_bcommits()
            end,
            desc = 'Git Previous commits',
        },
        {
            '<leader>gb',
            function()
                require('fzf-lua').git_branches()
            end,
            desc = 'Git Branch',
        },
        {
            '<leader>gS',
            function()
                require('fzf-lua').git_stash()
            end,
            desc = 'Git Stashes',
        },
        {
            '<leader>gs',
            function()
                require('fzf-lua').git_status()
            end,
            desc = 'Git Status',
        },
        {
            '<leader>lr',
            function()
                require('fzf-lua').lsp_references()
            end,
            desc = 'List symbol References',
        },
        {
            '<leader>li',
            function()
                require('fzf-lua').lsp_implementations()
            end,
            desc = 'List Implementations',
        },
        {
            '<leader>lO',
            function()
                require('fzf-lua').lsp_outcoming_calls()
            end,
            desc = 'List Outcoming calls',
        },
        {
            '<leader>lI',
            function()
                require('fzf-lua').lsp_incoming_calls()
            end,
            desc = 'List Incoming calls',
        },
        {
            '<leader>m',
            function()
                require('fzf-lua').marks()
            end,
            desc = 'List Marks',
        },
    },
    opts = function()
        local actions = require('fzf-lua.actions')
        return {
            files = {
                fzf_opts = {
                    ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-files-history',
                },
            },
            actions = {
                files = {
                    -- instead of the default action 'actions.file_edit_or_qf'
                    -- it's important to define all other actions here as this
                    -- table does not get merged with the global defaults
                    ['default'] = actions.file_edit_or_qf,
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-v'] = actions.file_vsplit,
                    ['ctrl-t'] = actions.file_tabedit,
                    ['alt-q'] = actions.file_sel_to_qf,
                    ['alt-l'] = actions.file_sel_to_ll,
                },
                buffers = {
                    -- providers that inherit these actions:
                    --   buffers, tabs, lines, blines
                    ['default'] = actions.buf_edit,
                    ['ctrl-x'] = actions.buf_split,
                    ['ctrl-v'] = actions.buf_vsplit,
                    ['ctrl-t'] = actions.buf_tabedit,
                },
            },
        }
    end,
    config = function(_, opts)
        -- calling `setup` is optional for customization
        require('fzf-lua').setup({ 'default' }, opts)
    end,
}
