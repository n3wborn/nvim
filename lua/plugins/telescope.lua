return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
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
        { '<space>b', '<cmd>Telescope before<CR>', desc = 'Telescope [B]efore' },
    },
    config = function(opts)
        require('telescope').setup(opts)
    end,
}
