-- https://github.com/nvim-telescope/telescope.nvim

require('telescope').setup {
    defaults = {
        sorting_strategy = "ascending",
        mappings = { i = { ["<ESC>"] = require('telescope.actions').close, }}
    },
}

-- Mappings

local map  = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

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
-- Telescope project
map('n', '<C-p>', [[:lua require'telescope'.extensions.project.project{}<CR>]], opts)
-- Extensions example
--map('n', 'leader>gw', [[<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>]], opts)
