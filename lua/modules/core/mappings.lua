--- Mappings
local u = require('utils')

-- map key
vim.g.mapleader = ','

u.map('n', '<leader>R', '<cmd>source $MYVIMRC<cr>')

-- easier windows jump
u.map('n', '<C-h>', '<C-w>h')
u.map('n', '<C-Left>', '<C-w>h')
u.map('n', '<C-l>', '<C-w>l')
u.map('n', '<C-Right>', '<C-w>l')
u.map('n', '<C-j>', '<C-w>j')
u.map('n', '<C-Down>', '<C-w>j')
u.map('n', '<C-k>', '<C-w>k')
u.map('n', '<C-Up>', '<C-w>k')
u.map('n', '<leader><space>', '<cmd>nohlsearch<cr>')

--- Resize windows
u.map('n', '<leader>+', '<cmd>vertical resize +10<cr>')
u.map('n', '<leader>-', '<cmd>vertical resize -10<cr>')

u.map('n', '<space>+', '<cmd>resize +5<cr>')
u.map('n', '<space>-', '<cmd>resize -5<cr>')

--- File explorer
u.map('n', '<leader>e', [[<cmd>lua require('nvim-tree').toggle()<cr>]])
u.map('n', '<leader>tr', [[<cmd>lua require('nvim-tree').refresh()<cr>]])

--- Quick file save
u.map('n', '<leader>ss', '<cmd>w<cr>')

--- Phpcbf - Php-cs-fixer
u.map('n', '<leader>FB', '<cmd>!phpcbf %<cr>') -- *B*eautify
u.map('n', '<leader>FS', '<cmd>!php-cs-fixer --rules=@Symfony --using-cache=no fix %<cr>') -- *F*ix (Symfony)
u.map('n', '<leader>FP', '<cmd>!php-cs-fixer --rules=@PSR12 --using-cache=no fix %<cr>') -- *F*ix (PSR12)

-- Format
u.map('n', '<space>F', '<cmd>FormatWrite<cr>')
u.map('v', '<space>F', '<cmd>FormatWrite<cr>')

--- Git
u.map('n', '<space>G', [[<cmd>lua require('neogit').open({ kind = 'split' })<cr>]])

--- keep text selected after indentation
u.map('v', '<', '<gv')
u.map('v', '>', '>gv')

--- move current line up/down
u.map('v', 'J', ":m '>+1<CR>gv=gv")
u.map('v', 'K', ":m '<-2<CR>gv=gv")

-- u.map Ctrl-c to Escape
u.map('i', '<C-c>', '')
u.map('i', '<C-c>', '<Esc>')

-- close current window
u.map('n', '<C-c><C-c>', '<cmd>close<cr>')

--- Copy-paste
u.map('v', '<leader>p', '"_dP')
u.map('n', '<leader>y', '"+y')
u.map('v', '<leader>y', '"+y')
u.map('n', '<leader>Y', 'gg"+yG')
u.map('n', '<leader>d', '"_d')
u.map('v', '<leader>d', '"_d')

--- Kommentary
vim.g.kommentary_create_default_mappings = false
u.map('n', '<C-_>', '<Plug>kommentary_line_default', {})
u.map('x', '<C-_>', '<Plug>kommentary_visual_default', {})

--- Easy Align
u.map('n', 'ga', ':EasyAlign<cr>')
u.map('x', 'ga', ':EasyAlign<cr>')
u.map('v', 'ga', ':EasyAlign<cr>')
u.map('n', 'iga', ':LiveEasyAlign<cr>')
u.map('x', 'iga', ':LiveEasyAlign<cr>')
u.map('v', 'iga', ':LiveEasyAlign<cr>')
