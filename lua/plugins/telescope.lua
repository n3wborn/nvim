-- telescope

require("telescope").setup {
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
        prompt_position = "top",
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_defaults = {
            horizontal = {
                mirror = false,
                preview_width = 0.5
            },
            vertical = {
                mirror = false
            }
        },
        file_sorter = require "telescope.sorters".get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        file_previewer = require "telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
        qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
    },
    extensions = {      -- require 'nvim-telescope/telescope-media-files.nvim'
        media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg" --
        }
    }
}

-- media_files extension
-- see https://github.com/nvim-telescope/telescope-media-files.nvim for softwares used as previewers
require("telescope").load_extension("media_files")


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
