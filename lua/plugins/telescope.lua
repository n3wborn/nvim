return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    tag = '0.1.8',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        --- @note: seems this can't live with fzf-lua
        -- {
        --     'nvim-telescope/telescope-fzf-native.nvim',
        --     build = 'make',
        --     config = function()
        --         require('telescope').load_extension('fzf')
        --     end,
        -- },
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
                    --- @note: seems this can't live with fzf-lua
                    -- fzf = {
                    --     fuzzy = true,
                    --     override_generic_sorter = true,
                    --     override_file_sorter = true,
                    -- },
                },
            },
        }
    end,
    keys = {
        { '<space>T', ':Telescope<CR>', desc = '[T]elescope' },
        { '<space>G', '<cmd>Telescope lazygit<CR>', desc = 'Telescope Lazy[G]it' },
        { '<space>b', '<cmd>Telescope before<CR>', desc = 'Telescope [B]efore' },
    },
    config = function(opts)
        require('telescope').setup(opts)
    end,
}
