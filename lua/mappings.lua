--- Mappings
local g    = vim.g
local map  = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

-- map key
g.mapleader = ','

map('n', '<leader>R', ':source $MYVIMRC<cr>', opts)

-- easier windows jump
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-Left>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-Right>', '<C-w>l', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-Down>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-Up>', '<C-w>k', opts)
map('n', '<leader><space>', ':nohlsearch<cr>', opts)

--- Resize windows
map('n', '<leader>+', ':vertical resize +10<cr>', opts)
map('n', '<leader>-', ':vertical resize -10<cr>', opts)

map('n', '<space>+', ':resize +5<cr>', opts)
map('n', '<space>-', ':resize -5<cr>', opts)

--- File explorer
map('n', '<leader>e', ':NvimTreeToggle<cr>', opts)
map('n', '<leader>tr', ':NvimTreeRefresh<cr>', opts)

--- Quick file save
map('n', '<leader>ss', ':w<cr>', opts)

--- Phpcbf - Php-cs-fixer
map('n', '<leader>B', ':!phpcbf %<cr>', opts) -- *B*eautify
map('n', '<leader>F', ':!php-cs-fixer --rules=@Symfony --using-cache=no fix %<cr>', opts) -- *F*ix

-- Format
map('n', '<space>f', [[:FormatWrite<cr>]], opts)
map('v', '<space>f', [[:FormatWrite<cr>]], opts)

--- Git
map('n', '<space>G', [[<cmd>lua require("neogit").open({ kind = "split" })<cr>]],  opts)

--- keep text selected after indentation
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

--- move current line up/down
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Map Ctrl-c to Escape
map('i', '<C-c>', '', opts)
map('i', '<C-c>', '<Esc>', opts)

--- Copy-paste
map('v', '<leader>p', '"_dP', opts)
map('n', '<leader>y', '"+y', opts)
map('v', '<leader>y', '"+y', opts)
map('n', '<leader>Y', 'gg"+yG', opts)
map('n', '<leader>d', '"_d', opts)
map('v', '<leader>d', '"_d', opts)

--- Commentary
map('n', '<C-_>', ':Commentary<cr>', opts)
map('v', '<C-_>', ':Commentary<cr>', opts)

--- Easy Align
map('n', 'ga', ':EasyAlign<cr>', opts)
map('x', 'ga', ':EasyAlign<cr>', opts)
map('v', 'ga', ':EasyAlign<cr>', opts)
map('n', 'iga', ':LiveEasyAlign<cr>', opts)
map('x', 'iga', ':LiveEasyAlign<cr>', opts)
map('v', 'iga', ':LiveEasyAlign<cr>', opts)

