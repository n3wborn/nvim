return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
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
    opts = {
        defaults = {
            prompt_prefix = '❯ ',
            selection_caret = '❯ ',
            sorting_strategy = 'ascending',
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                },
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
    cmd = { 'Telescope' },
    keys = {
        { '<Leader>T', ':Telescope<CR>', desc = 'Telescope' },
        { '<space>G', '<cmd>Telescope lazygit<CR>', desc = 'Telescope Lazygit' },
        {
            '<leader>f',
            function()
                require('telescope.builtin').find_files()
            end,
            desc = 'Find Plugin File',
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
    },
    config = function(opts)
        require('telescope').setup(opts)
    end,
}
