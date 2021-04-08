--- Mappings
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local map = vim.api.nvim_set_keymap

-- map key
g.mapleader = ','

-- set options here to not repeat them each time
options = { noremap = true }
opt_nmap_silent = { noremap = true, silent = true }

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
-- Ex|-> :nnoremap <silent> <Leader><Space> :set hlsearch<CR>
map('n', '<leader><space>', ':nohlsearch<cr>', options)
-- FZF/Ag/Ripgrep
map('n', '<leader>f', ':FZF<cr>', options)
map('n', '<leader>b', ':Buffers<cr>', options)
map('n', '<leader>g', ':GitFiles<cr>', options)
map('n', '<leader>a', ':Ag<cr>', options)

-- git/fugitive/gitgutter (replaced by gitsigns)
-- map('n', '<leader>gf', ':diffget //2<cr>', options)
-- map('n', '<leader>gh', ':diffget //3<cr>', options)
-- map('n', '<leader>gs', ':G<cr>', options)
-- next/prev hunk
-- map('n', '<space>n', '<Plug>(GitGutterNextHunk)', { silent = true })
-- map('n', '<space>N', '<Plug>(GitGutterPrevHunk)', { silent = true })
-- stage/instage hunk
-- map('n', '<space>s', '<Plug>(GitGutterStageHunk)', { silent = true })
-- map('n', '<space>u', '<Plug>(GitGutterUndoHunk)', { silent = true })
-- hunk infos
-- map('n', '<space>i', '<Plug>(GitGutterPreviewHunk)', { silent = true })
-- quickfix list
-- map('n', '<space>q', ':GitGutterQuickFix<CR>', options)
-- fold unmodified lines
-- vim.api.nvim_set_keymap('n', '<space>F', ':GitGutterFold<CR>', options)


--- Vertical resize
map('n', '<leader>+', ':vertical resize +10<cr>', options)
map('n', '<leader>-', ':vertical resize -10<cr>', options)
--- COC Goto's
map('n', 'gd', '<Plug>(coc-definition)', { silent = true })
map('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
map('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
map('n', 'gr', '<Plug>(coc-references)', { silent = true })
--- Use K to show documentation in preview window (Or :help for vim keywords).
map('n', 'k', ':call ShowDocumentation()<cr>', { silent = true })
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



--
-- Insert Mode
--

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true})

--- Manually trigger completion
map('i', '<C-space>', '<Plug>(completion_trigger)', { expr = true})



---
-- Related Ones
---

--- copy-paste
--- greatest remap ever
map('v', '<leader>p', '"_dP"', options)

--- next greatest remap ever : asbjornHaland
map('n', '<leader>y', '"+y', options)
map('v', '<leader>y', '"+y', options)
map('n', '<leader>Y', 'gg"+yG', options)

map('n', '<leader>d', '"_d"', options)
map('v', '<leader>d', '"_d"', options)

--- commentary
-- <C-_> = ctrl /
map('n', '<C-_>', ':Commentary<cr>', options)
map('v', '<C-_>', ':Commentary<cr>', options)

--- Easy Align
map('n', 'ga', '<Plug>(EasyAlign)', options)
map('x', 'ga', '<Plug>(EasyAlign)', options)

map('n', 'iga', '<Plug>(LiveEasyAlign)', options)
map('x', 'iga', '<Plug>(LiveEasyAlign)', options)

--- Telescope
--map('n', '<space>e', ':Telescope file_browser<cr>', options)
map('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]],  opt_nmap_silent)
map('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<cr>]],  opt_nmap_silent)
map('n', '<leader>l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]],  opt_nmap_silent)
map('n', '<leader>t', [[<cmd>lua require('telescope.builtin').tags()<cr>]],  opt_nmap_silent)
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]],  opt_nmap_silent)
map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]],  opt_nmap_silent)
map('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],  opt_nmap_silent)
map('n', '<leader>o', [[<cmd>lua require('telescope.builtin').tags only_current_buffer = true <cr>]], opt_nmap_silent)
map('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]],  opt_nmap_silent)
map('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]],  opt_nmap_silent)
map('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]],  opt_nmap_silent)
map('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]],  opt_nmap_silent)
map('n', '<leader>wb', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]],  opt_nmap_silent)

