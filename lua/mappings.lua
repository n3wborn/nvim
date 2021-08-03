--- Mappings
local map = require('utils').map

-- map key
vim.g.mapleader = ','

map('n', '<leader>R', ':source $MYVIMRC<cr>')

-- easier windows jump
map('n', '<C-h>', '<C-w>h')
map('n', '<C-Left>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-Right>', '<C-w>l')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-Down>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-Up>', '<C-w>k')
map('n', '<leader><space>', ':nohlsearch<cr>')

--- Resize windows
map('n', '<leader>+', ':vertical resize +10<cr>')
map('n', '<leader>-', ':vertical resize -10<cr>')

map('n', '<space>+', ':resize +5<cr>')
map('n', '<space>-', ':resize -5<cr>')

--- File explorer
map('n', '<leader>e', ':NvimTreeToggle<cr>')
map('n', '<leader>tr', ':NvimTreeRefresh<cr>')

--- Quick file save
map('n', '<leader>ss', ':w<cr>')

--- Phpcbf - Php-cs-fixer
map('n', '<leader>B', ':!phpcbf %<cr>') -- *B*eautify
map('n', '<leader>F', ':!php-cs-fixer --rules=@Symfony --using-cache=no fix %<cr>') -- *F*ix

-- Format
map('n', '<space>f', [[:FormatWrite<cr>]])
map('v', '<space>f', [[:FormatWrite<cr>]])

--- Git
map('n', '<space>G', [[<cmd>lua require("neogit").open({ kind = "split" })<cr>]])

--- keep text selected after indentation
map('v', '<', '<gv')
map('v', '>', '>gv')

--- move current line up/down
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- map Ctrl-c to Escape
map('i', '<C-c>', '')
map('i', '<C-c>', '<Esc>')

-- map Ctrl-h to close :help windows
map('n', '<C-h>', ':helpclose<cr>')
map('i', '<C-h>', ':helpclose<cr>')

--- Copy-paste
map('v', '<leader>p', '"_dP')
map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')
map('n', '<leader>Y', 'gg"+yG')
map('n', '<leader>d', '"_d')
map('v', '<leader>d', '"_d')

--- Commentary
map('n', '<C-_>', ':Commentary<cr>')
map('v', '<C-_>', ':Commentary<cr>')

--- Easy Align
map('n', 'ga', ':EasyAlign<cr>')
map('x', 'ga', ':EasyAlign<cr>')
map('v', 'ga', ':EasyAlign<cr>')
map('n', 'iga', ':LiveEasyAlign<cr>')
map('x', 'iga', ':LiveEasyAlign<cr>')
map('v', 'iga', ':LiveEasyAlign<cr>')
