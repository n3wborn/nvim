--- Mappings
local map = require('utils').map

-- map key
vim.g.mapleader = ','

map('n', '<leader>R', '<cmd>source $MYVIMRC<cr>')

-- easier windows jump
map('n', '<C-h>', '<C-w>h')
map('n', '<C-Left>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-Right>', '<C-w>l')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-Down>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-Up>', '<C-w>k')
map('n', '<leader><space>', '<cmd>nohlsearch<cr>')

--- Resize windows
map('n', '<leader>+', '<cmd>vertical resize +10<cr>')
map('n', '<leader>-', '<cmd>vertical resize -10<cr>')

map('n', '<space>+', '<cmd>resize +5<cr>')
map('n', '<space>-', '<cmd>resize -5<cr>')

--- File explorer
map('n', '<leader>e', [[<cmd>lua require('nvim-tree').toggle()<cr>]])
map('n', '<leader>tr', [[<cmd>lua require('nvim-tree').refresh()<cr>]])

--- Quick file save
map('n', '<leader>ss', '<cmd>w<cr>')

--- Phpcbf - Php-cs-fixer
map('n', '<leader>FB', '<cmd>!phpcbf %<cr>') -- *B*eautify
map('n', '<leader>FS', '<cmd>!php-cs-fixer --rules=@Symfony --using-cache=no fix %<cr>') -- *F*ix (Symfony)
map('n', '<leader>FP', '<cmd>!php-cs-fixer --rules=@PSR12 --using-cache=no fix %<cr>')   -- *F*ix (PSR12)

-- Format
map('n', '<space>f', '<cmd>FormatWrite<cr>')
map('v', '<space>f', '<cmd>FormatWrite<cr>')

--- Git
map('n', '<space>G', [[<cmd>lua require('neogit').open({ kind = 'split' })<cr>]])

--- keep text selected after indentation
map('v', '<', '<gv')
map('v', '>', '>gv')

--- move current line up/down
map('v', 'J', [[<cmd>m '>+1<CR>gv=gv]])
map('v', 'K', [[<cmd>m '<-2<CR>gv=gv]])

-- map Ctrl-c to Escape
map('i', '<C-c>', '')
map('i', '<C-c>', '<Esc>')

-- close current window
map('n', '<C-c><C-c>', '<cmd>close<cr>')

-- map Ctrl-h to close :help windows
map('n', '<C-h>', '<cmd>helpclose<cr>')
map('i', '<C-h>', '<cmd>helpclose<cr>')

--- Copy-paste
map('v', '<leader>p', '"_dP')
map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')
map('n', '<leader>Y', 'gg"+yG')
map('n', '<leader>d', '"_d')
map('v', '<leader>d', '"_d')

--- Commentary
map('n', '<C-_>', '<cmd>Commentary<cr>')
map('v', '<C-_>', '<cmd>Commentary<cr>')

--- Easy Align
map('n', 'ga', '<cmd>EasyAlign<cr>')
map('x', 'ga', '<cmd>EasyAlign<cr>')
map('v', 'ga', '<cmd>EasyAlign<cr>')
map('n', 'iga', '<cmd>LiveEasyAlign<cr>')
map('x', 'iga', '<cmd>LiveEasyAlign<cr>')
map('v', 'iga', '<cmd>LiveEasyAlign<cr>')
