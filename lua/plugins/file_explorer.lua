return {
    {
        'stevearc/oil.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = 'Oil',
        event = 'VeryLazy',
        config = function()
            require('oil').setup({
                columns = { 'icon' },
                keymaps = {
                    ['<C-h>'] = false,
                    ['<M-h>'] = 'actions.select_split',
                },
                view_options = {
                    show_hidden = true,
                },
            })

            -- Open parent directory in current window
            vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

            -- Open parent directory in floating window
            vim.keymap.set('n', '<space>-', require('oil').toggle_float)
        end,
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            {
                's1n7ax/nvim-window-picker',
                config = function()
                    require('window-picker').setup({
                        autoselect_one = true,
                        selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                    })
                end,
            },
        },
        cmd = 'Neotree',
        lazy = false,
        opts = {
            auto_clean_after_session_restore = false, -- Automatically clean up broken neo-tree buffers saved in sessions
            close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
            open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
            sort_case_insensitive = false, -- used when sorting files and directories in the tree
            sort_function = nil, -- use a custom function for sorting files and directories in the tree
            window = {
                position = 'left',
                width = 60,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ['P'] = { 'toggle_preview', config = { use_float = true } },
                    ['<c-s>'] = function(state)
                        require('neo-tree.sources.filesystem.commands').split_with_window_picker(state)
                    end,
                    ['<c-v>'] = function(state)
                        require('neo-tree.sources.filesystem.commands').vsplit_with_window_picker(state)
                    end,
                    ['<c-t>'] = function(state)
                        require('neo-tree.sources.filesystem.commands').open_tabnew(state)
                    end,
                },
            },
            nesting_rules = {},
            filesystem = {
                filtered_items = {
                    visible = false, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_by_name = {
                        'node_modules',
                        '.cache',
                        'build',
                        'var',
                        'vendor',
                    },
                    hide_by_pattern = {}, -- uses glob style patterns
                    always_show = {
                        '.gitignored',
                        '.env*',
                    },
                    never_show = {}, -- remains hidden even if visible is toggled to true, this overrides always_show
                    never_show_by_pattern = {}, -- uses glob style patterns
                },
                follow_current_file = {
                    enabled = true,
                },
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                },
                group_empty_dirs = true, -- when true, empty folders will be grouped together
                show_unloaded = false,
            },
            event_handlers = {
                {
                    event = 'file_opened',
                    handler = function()
                        require('neo-tree.command').execute({ action = 'close' })
                    end,
                },
            },
        },
        keys = {
            { '<leader>e', '<cmd>Neotree toggle=true<cr>', desc = 'neotree' },
        },
    },
}
