return {
    'nvim-telescope/telescope.nvim',
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
            'nvim-telescope/telescope-ui-select.nvim',
            config = function()
                require('telescope').load_extension('ui-select')
            end,
        },
        {
            'nvim-telescope/telescope-project.nvim',
            keys = {
                { '<C-p>', '<cmd>Telescope project<CR>', desc = 'Telescope Projects' },
            },
            config = function()
                require('telescope').load_extension('project')
            end,
        },
        {
            'kdheepak/lazygit.nvim',
            config = function()
                require('telescope').load_extension('lazygit')

                vim.api.nvim_create_autocmd('BufEnter', {
                    desc = 'makes sure any opened buffer inside a git repo will be tracked by lazygit',
                    callback = function()
                        require('lazygit.utils').project_root_dir()
                    end,
                    group = vim.api.nvim_create_augroup('Lazygit', { clear = false }),
                })

                vim.keymap.set('n', '<space>G', '<cmd>Telescope lazygit<CR>')
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
            desc = '',
        },
        {
            '<leader>o',
            function()
                require('telescope.builtin').oldfiles()
            end,
            desc = '',
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
            desc = '',
        },
        {
            '<leader>gp',
            function()
                require('telescope.builtin').git_bcommits()
            end,
            desc = '',
        },
        {
            '<leader>gb',
            function()
                require('telescope.builtin').git_branches()
            end,
            desc = '',
        },
        {
            '<leader>gS',
            function()
                require('telescope.builtin').git_stash()
            end,
            desc = '',
        },
        {
            '<leader>gs',
            function()
                require('telescope.builtin').git_status()
            end,
            desc = '',
        },
        {
            '<leader>lr',
            function()
                require('telescope.builtin').lsp_references()
            end,
            desc = '',
        },
        {
            '<leader>ls',
            function()
                require('telescope.builtin').lsp_workspace_symbols()
            end,
            desc = '',
        },
        {
            '<leader>li',
            function()
                require('telescope.builtin').lsp_implementations()
            end,
            desc = '',
        },
    },
    config = function(opts)
        require('telescope').setup(opts)
    end,
}
