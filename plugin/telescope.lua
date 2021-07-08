-- telescope

local actions    = require('telescope.actions')
local previewers = require('telescope.previewers')
local sorters    = require('telescope.sorters')
local telescope  = require('telescope')

telescope.setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case"
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                mirror = false,
            },
            vertical = {
                mirror = false,
            },
        },
        file_sorter = sorters.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        path_display = {},
        winblend = 0,
        border = {},
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"},
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        mappings = { i = { ["<ESC>"] = actions.close, }
        }
    }
}

-- Mappings

local map  = vim.api.nvim_set_keymap
local opts = { noremap = true }

-- Call Telescope
map('n', '<leader>T', [[:Telescope<cr>]],  opts)

-- General builtins
map('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],  opts)
map('n', '<leader>f' , [[<cmd>lua require('telescope.builtin').find_files()<cr>]],  opts)
map('n', '<leader>b' , [[<cmd>lua require('telescope.builtin').buffers()<cr>]],  opts)
map('n', '<leader>t' , [[<cmd>lua require('telescope.builtin').tags()<cr>]],  opts)
map('n', '<leader>?' , [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]],  opts)
map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]],  opts)
map('n', '<leader>E' , [[<cmd>lua require('telescope.builtin').file_browser()<cr>]],  opts)
map('n', '<leader>t' , [[<cmd>lua require('telescope.builtin').treesitter()<cr>]],  opts)
-- Git builtins
map('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]],  opts)
map('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]],  opts)
map('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]],  opts)
map('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]],  opts)
map('n', '<leader>gS', [[<cmd>lua require('telescope.builtin').git_stash()<cr>]],  opts)
-- lsp builtins
map('n', '<leader>ls', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]],  opts)
map('n', '<leader>lD', [[<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>]],  opts)
map('n', '<leader>lr', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]],  opts)
map('n', '<leader>li', [[<cmd>lua require('telescope.builtin').lsp_implementations()<cr>]],  opts)
map('n', '<leader>ld', [[<cmd>lua require('telescope.builtin').lsp_definitions()<cr>]],  opts)
-- Extensions example
--map('n', 'leader>gw', [[<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>]], opts)
