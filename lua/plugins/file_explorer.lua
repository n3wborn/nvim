return {
    {
        'Rizwanelansyah/simplyfile.nvim',
        config = function()
            require('simplyfile').setup({
                border = {
                    left = 'rounded',
                    main = 'double',
                    right = 'rounded',
                },
                default_keymaps = true,
            })
        end,
    },
    -- {
    --     'nvim-neo-tree/neo-tree.nvim',
    --     branch = 'v3.x',
    --     dependencies = {
    --         'MunifTanjim/nui.nvim',
    --         'nvim-lua/plenary.nvim',
    --         'nvim-tree/nvim-web-devicons',
    --         {
    --             's1n7ax/nvim-window-picker',
    --             config = function()
    --                 require('window-picker').setup({
    --                     autoselect_one = true,
    --                     selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    --                 })
    --             end,
    --         },
    --     },
    --     cmd = 'Neotree',
    --     opts = {
    --         close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    --         popup_border_style = _G.global.float_border_opts.border,
    --         enable_git_status = true,
    --         enable_diagnostics = true,
    --         open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
    --         sort_case_insensitive = false, -- used when sorting files and directories in the tree
    --         sort_function = nil, -- use a custom function for sorting files and directories in the tree
    --         window = {
    --             position = 'left',
    --             width = 40,
    --             mapping_options = {
    --                 noremap = true,
    --                 nowait = true,
    --             },
    --             mappings = {
    --                 ['P'] = { 'toggle_preview', config = { use_float = true } },
    --                 ['<c-x>'] = function(state)
    --                     require('neo-tree.sources.filesystem.commands').split_with_window_picker(state)
    --                 end,
    --                 ['<c-v>'] = function(state)
    --                     require('neo-tree.sources.filesystem.commands').vsplit_with_window_picker(state)
    --                 end,
    --                 ['<c-t>'] = function(state)
    --                     require('neo-tree.sources.filesystem.commands').open_tabnew(state)
    --                 end,
    --             },
    --         },
    --         nesting_rules = {},
    --         filesystem = {
    --             filtered_items = {
    --                 visible = false, -- when true, they will just be displayed differently than normal items
    --                 hide_dotfiles = true,
    --                 hide_gitignored = true,
    --                 hide_by_name = {
    --                     'node_modules',
    --                     '.cache',
    --                     'build',
    --                     'var',
    --                     'vendor',
    --                 },
    --                 hide_by_pattern = {}, -- uses glob style patterns
    --                 always_show = {
    --                     '.gitignored',
    --                     '.env*',
    --                 },
    --                 never_show = {}, -- remains hidden even if visible is toggled to true, this overrides always_show
    --                 never_show_by_pattern = {}, -- uses glob style patterns
    --             },
    --             follow_current_file = {
    --                 enabled = true,
    --             },
    --         },
    --         buffers = {
    --             follow_current_file = {
    --                 enabled = true,
    --             },
    --             group_empty_dirs = true, -- when true, empty folders will be grouped together
    --             show_unloaded = true,
    --         },
    --     },
    --     keys = {
    --         { '<leader>e', '<cmd>Neotree toggle=true<cr>', desc = 'neotree' },
    --     },
    --     config = function(_, opts)
    --         require('neo-tree').setup(opts)
    --     end,
    -- },
}
