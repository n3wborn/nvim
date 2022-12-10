--- Mappings
local u = require('utils')

-- map key
vim.g.mapleader = ','

-- source config
u.map('n', '<leader>R', '<cmd>source $MYVIMRC<cr>')

-- fix indentation
u.map('n', '<leader>i', 'mmgg=G`m<cr>')

-- easier windows jump
u.map('n', '<C-Left>', '<C-w>h')
u.map('n', '<C-Right>', '<C-w>l')
u.map('n', '<C-Down>', '<C-w>j')
u.map('n', '<C-Up>', '<C-w>k')

--- Resize windows
u.map('n', '<leader>+', '<cmd>vertical resize +10<cr>')
u.map('n', '<leader>-', '<cmd>vertical resize -10<cr>')

u.map('n', '<space>+', '<cmd>resize +5<cr>')
u.map('n', '<space>-', '<cmd>resize -5<cr>')

--- Quick file save
u.map('n', '<leader>ss', '<cmd>w<cr>')

--- Phpcbf - Php-cs-fixer
u.map('n', '<leader>FB', '<cmd>!phpcbf %<cr>') -- *B*eautify
u.map('n', '<leader>FS', '<cmd>!php-cs-fixer --rules=@Symfony --using-cache=no fix %<cr>') -- *F*ix (Symfony)
u.map('n', '<leader>FP', '<cmd>!php-cs-fixer --rules=@PSR12 --using-cache=no fix %<cr>') -- *F*ix (PSR12)
u.map('n', '<leader>FF', '<cmd>!php-cs-fixer --rules=@PSR12,@Symfony --using-cache=no fix %<cr>')

--- Git
u.map('n', '<leader>gh', ':diffget //3<cr>')
u.map('n', '<leader>gu', ':diffget //2<cr>')

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
