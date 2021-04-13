--- Mappings
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local map = vim.api.nvim_set_keymap
local options = { noremap = true }
local opt_nmap_silent = { noremap = true, silent = true }

-- map key
g.mapleader = ','

--
-- Normal Mode
--
-- easier windows jump
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-Left>', '<C-w>h', options)
map('n', '<C-l>', '<C-w>l', options)
map('n', '<C-Right>', '<C-w>l', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-Down>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
map('n', '<C-Up>', '<C-w>k', options)
map('n', '<leader><space>', ':nohlsearch<cr>', options)

--- Vertical resize
map('n', '<leader>+', ':vertical resize +10<cr>', options)
map('n', '<leader>-', ':vertical resize -10<cr>', options)

--- File explorer
map('n', '<leader>e', ':NvimTreeToggle<cr>', options)
map('n', '<leader>tr', ':NvimTreeRefreshe<cr>', options)

--- Quick file save
map('n', '<leader>ss', ':w<cr>', options)

--- Phpcbf
map('n', '<leader>pcb', ':!phpcbf %<cr>', { silent = true })



--
-- Visual Mode
--

--- keep text selected after indentation
map('v', '<', '<gv', options)
map('v', '>', '>gv', options)


--- move current line up/down
map('v', 'J', ":m '>+1<CR>gv=gv", options)
map('v', 'K', ":m '<-2<CR>gv=gv", options)



---
-- Related Ones
---

--- Copy-paste
--- greatest remap ever
map('v', '<leader>p', '"_dP"', options)

--- next greatest remap ever : asbjornHaland
map('n', '<leader>y', '"+y', options)
map('v', '<leader>y', '"+y', options)
map('n', '<leader>Y', 'gg"+yG', options)

map('n', '<leader>d', '"_d"', options)
map('v', '<leader>d', '"_d"', options)

--- Commentary
-- <C-_> = ctrl /
map('n', '<C-_>', ':Commentary<cr>', options)
map('v', '<C-_>', ':Commentary<cr>', options)

--- Easy Align
map('n', 'ga', '<Plug>(EasyAlign)', options)
map('x', 'ga', '<Plug>(EasyAlign)', options)

map('n', 'iga', '<Plug>(LiveEasyAlign)', options)
map('x', 'iga', '<Plug>(LiveEasyAlign)', options)

--- Telescope Files/Grep/Tags/Buffer Stuff
map('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],  opt_nmap_silent)
map('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]],  opt_nmap_silent)
map('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<cr>]],  opt_nmap_silent)
map('n', '<leader>l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]],  opt_nmap_silent)
map('n', '<leader>t', [[<cmd>lua require('telescope.builtin').tags()<cr>]],  opt_nmap_silent)
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]],  opt_nmap_silent)
map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]],  opt_nmap_silent)
map('n', '<leader>o', [[<cmd>lua require('telescope.builtin').tags only_current_buffer = true <cr>]], opt_nmap_silent)
-- Telescope Git Stuff
map('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]],  opt_nmap_silent)
map('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]],  opt_nmap_silent)
map('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]],  opt_nmap_silent)
map('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]],  opt_nmap_silent)
map('n', '<leader>wb', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]],  opt_nmap_silent)

