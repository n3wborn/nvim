return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    tag = '0.1.5',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            config = function()
                require('telescope').load_extension('fzf')
            end,
        },
        {
            'kdheepak/lazygit.nvim',
            event = { 'VeryLazy' },
            config = function()
                require('telescope').load_extension('lazygit')
                require('telescope').load_extension('before')

                vim.api.nvim_create_autocmd('BufEnter', {
                    desc = 'makes sure any opened buffer inside a git repo will be tracked by lazygit',
                    callback = function()
                        require('lazygit.utils').project_root_dir()
                    end,
                    group = vim.api.nvim_create_augroup('Lazygit', { clear = false }),
                })
            end,
        },
    },
    opts = function()
        local actions = require('telescope.actions')

        return {
            defaults = {
                prompt_prefix = '❯ ',
                selection_caret = '❯ ',
                sorting_strategy = 'ascending',
                buffers = {
                    show_all_buffers = true,
                    sort_mru = true,
                    mappings = {
                        i = {
                            ['<c-d>'] = 'delete_buffer',
                        },
                    },
                },
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                    n = {
                        ['q'] = actions.close,
                    },
                },
                pickers = {
                    git_files = {
                        show_untracked = true,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                    },
                },
            },
        }
    end,
    keys = {
        { '<Leader>T', ':Telescope<CR>', desc = 'Telescope' },
        { '<space>G', '<cmd>Telescope lazygit<CR>', desc = 'Telescope Lazy[G]it' },
        { '<space>b', '<cmd>Telescope before<CR>', desc = 'Telescope [B]efore' },
        {
            '<leader>ff',
            function()
                require('telescope.builtin').find_files({ cwd = false })
            end,
            desc = 'Find File',
        },
        {
            '<leader>fF',
            function()
                require('telescope.builtin').find_files({
                    search_dirs = { 'plugins', 'lib', 'modules' },
                    hidden = true,
                    prompt_title = 'Find Files in plugins,lib,modules dirs',
                })
            end,
            desc = 'Find File in plugins,lib,modules dirs',
        },
        {
            '<leader>sp',
            function()
                require('telescope.builtin').live_grep()
            end,
            desc = 'Live Grep',
        },
        {
            '<leader>sd',
            function()
                require('telescope.builtin').grep_string()
            end,
            desc = 'Grep current string',
        },
        {
            '<leader>o',
            function()
                require('telescope.builtin').oldfiles()
            end,
            desc = 'Old files opened',
        },
        {
            '<leader>b',
            function()
                require('telescope.builtin').buffers()
            end,
            desc = 'Find in Buffers',
        },
        {
            '<leader>gc',
            function()
                require('telescope.builtin').git_commits()
            end,
            desc = 'Git commits',
        },
        {
            '<leader>gp',
            function()
                require('telescope.builtin').git_bcommits()
            end,
            desc = 'Previous git commits',
        },
        {
            '<leader>gb',
            function()
                require('telescope.builtin').git_branches()
            end,
            desc = 'Git branch',
        },
        {
            '<leader>gS',
            function()
                require('telescope.builtin').git_stash()
            end,
            desc = 'List git stashes',
        },
        {
            '<leader>gs',
            function()
                require('telescope.builtin').git_status()
            end,
            desc = 'Show git status',
        },
        {
            '<leader>lr',
            function()
                require('telescope.builtin').lsp_references()
            end,
            desc = 'List symbol references',
        },
        {
            '<leader>ls',
            function()
                require('telescope.builtin').lsp_workspace_symbols()
            end,
            desc = 'List workspace symbols',
        },
        {
            '<leader>li',
            function()
                require('telescope.builtin').lsp_implementations()
            end,
            desc = 'List symbol implementations',
        },
        {
            '<leader>m',
            function()
                require('telescope.builtin').marks()
            end,
            desc = 'List marks',
        },
    },
    config = function(opts)
        require('telescope').setup(opts)
    end,
}
