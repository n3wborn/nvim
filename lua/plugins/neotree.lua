return {
    {
        'nvim-neo-tree/neo-tree.nvim',
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
        opts = {
            close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
            popup_border_style = 'rounded',
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
            sort_case_insensitive = false, -- used when sorting files and directories in the tree
            sort_function = nil, -- use a custom function for sorting files and directories in the tree
            -- sort_function = function (a,b)
            --       if a.type == b.type then
            --           return a.path > b.path
            --       else
            --           return a.type > b.type
            --       end
            --   end , -- this sorts files and directories descendantly
            default_component_configs = {
                container = {
                    enable_character_fade = true,
                },
                indent = {
                    indent_size = 2,
                    padding = 1, -- extra padding on left hand side
                    -- indent guides
                    with_markers = true,
                    indent_marker = '│',
                    last_indent_marker = '└',
                    highlight = 'NeoTreeIndentMarker',
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = '',
                    expander_expanded = '',
                    expander_highlight = 'NeoTreeExpander',
                },
                icon = {
                    folder_closed = '',
                    folder_open = '',
                    folder_empty = 'ﰊ',
                    default = '*',
                    highlight = 'NeoTreeFileIcon',
                },
                modified = {
                    symbol = '[+]',
                    highlight = 'NeoTreeModified',
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = 'NeoTreeFileName',
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted = '✖', -- this can only be used in the git_status source
                        renamed = '', -- this can only be used in the git_status source
                        -- Status type
                        untracked = '',
                        ignored = '',
                        unstaged = '',
                        staged = '',
                        conflict = '',
                    },
                },
            },
            window = {
                position = 'left',
                width = 40,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ['<space>'] = {
                        'toggle_node',
                        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                    },
                    ['<2-LeftMouse>'] = 'open',
                    ['<cr>'] = 'open',
                    ['<esc>'] = 'revert_preview',
                    ['P'] = { 'toggle_preview', config = { use_float = true } },
                    ['<c-x>'] = function(state)
                        require('neo-tree.sources.filesystem.commands').split_with_window_picker(state)
                    end,
                    ['<c-v>'] = function(state)
                        require('neo-tree.sources.filesystem.commands').vsplit_with_window_picker(state)
                    end,
                    ['l'] = 'focus_preview',
                    ['t'] = 'open_tabnew',
                    -- ["<cr>"] = "open_drop",
                    -- ["t"] = "open_tab_drop",
                    ['w'] = 'open_with_window_picker',
                    --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                    ['C'] = 'close_node',
                    -- ['C'] = 'close_all_subnodes',
                    ['z'] = 'close_all_nodes',
                    --["Z"] = "expand_all_nodes",
                    ['a'] = {
                        'add',
                        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                        config = {
                            show_path = 'none', -- "none", "relative", "absolute"
                        },
                    },
                    ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
                    ['d'] = 'delete',
                    ['r'] = 'rename',
                    ['y'] = 'copy_to_clipboard',
                    ['x'] = 'cut_to_clipboard',
                    ['p'] = 'paste_from_clipboard',
                    ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
                    -- ["c"] = {
                    --  "copy",
                    --  config = {
                    --    show_path = "none" -- "none", "relative", "absolute"
                    --  }
                    --}
                    ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
                    ['q'] = 'close_window',
                    ['R'] = 'refresh',
                    -- ['?'] = 'show_help',
                    ['<'] = 'prev_source',
                    ['>'] = 'next_source',
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
                    follow_current_file = {
                        enabled = true,
                    },
                },
                window = {
                    mappings = {
                        ['<bs>'] = 'navigate_up',
                        ['.'] = 'set_root',
                        ['H'] = 'toggle_hidden',
                        ['/'] = 'fuzzy_finder',
                        ['D'] = 'fuzzy_finder_directory',
                        ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
                        -- ["D"] = "fuzzy_sorter_directory",
                        ['f'] = 'filter_on_submit',
                        ['<c-c>'] = 'clear_filter',
                        ['[g'] = 'prev_git_modified',
                        [']g'] = 'next_git_modified',
                    },
                    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                        ['<down>'] = 'move_cursor_down',
                        ['<C-n>'] = 'move_cursor_down',
                        ['<up>'] = 'move_cursor_up',
                        ['<C-p>'] = 'move_cursor_up',
                    },
                },
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                },
                group_empty_dirs = true, -- when true, empty folders will be grouped together
                show_unloaded = true,
                window = {
                    mappings = {
                        ['bd'] = 'buffer_delete',
                        ['<bs>'] = 'navigate_up',
                        ['.'] = 'set_root',
                    },
                },
            },
            git_status = {
                window = {
                    position = 'float',
                    mappings = {
                        ['A'] = 'git_add_all',
                        ['gu'] = 'git_unstage_file',
                        ['ga'] = 'git_add_file',
                        ['gr'] = 'git_revert_file',
                        ['gc'] = 'git_commit',
                        ['gp'] = 'git_push',
                        ['gg'] = 'git_commit_and_push',
                    },
                },
            },
        },
        keys = {
            { '<leader>e', '<cmd>Neotree toggle=true<cr>', desc = 'neotree' },
        },
        config = function(_, opts)
            require('neo-tree').setup(opts)
        end,
    },
}
