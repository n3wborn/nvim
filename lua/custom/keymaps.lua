--- Mappings
local u = require('utils')

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

-- save in insert mode
vim.keymap.set('i', '<C-s>', '<cmd>:w<cr><esc>')
vim.keymap.set('n', '<C-s>', '<cmd>:w<cr><esc>')
vim.keymap.set('n', '<C-c>', '<cmd>normal ciw<cr>a')

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
u.map('n', '<leader>Y', 'gg"+yG', { desc = 'Copy whole file' })
u.map('n', '<leader>d', '"_d', { desc = 'Delete without yank' })

--- Switch to previous buffer
u.map('n', '<leader><leader>', '<cmd>e #<cr>', { desc = 'Switch to previous buffer' })

--- keep cursor vertically centered while scrolling
u.map('n', '<C-d>', '<C-d>zz', { desc = 'Center cursor after moving down half-page' })
u.map('n', '<C-u>', '<C-u>zz', { desc = 'Center cursor after moving up half-page' })
u.map('n', '<C-f>', '<C-f>zz', { desc = 'Center cursor after moving forward page' })
u.map('n', '<C-b>', '<C-b>zz', { desc = 'Center cursor after moving backward page' })
