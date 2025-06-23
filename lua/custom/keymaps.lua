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
vim.keymap.set('n', '<C-s>', '<cmd>:w<cr><esc>')

--- Phpcbf - Php-cs-fixer
u.map('n', '<leader>FB', '<cmd>!phpcbf %<cr>') -- *B*eautify
u.map('n', '<leader>FS', '<cmd>!php-cs-fixer --rules=@Symfony --using-cache=no fix %<cr>') -- *F*ix (Symfony)
u.map('n', '<leader>FP', '<cmd>!php-cs-fixer --rules=@PSR12 --using-cache=no fix %<cr>') -- *F*ix (PSR12)
-- u.map('n', '<leader>FF', '<cmd>!php-cs-fixer --rules=@PSR12,@Symfony --using-cache=no fix %<cr>')
u.map('n', '<leader>FF', '<cmd>!docker compose exec php php-cs-fixer fix %<cr>')

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
u.map('n', '<space><space>', '<cmd>e #<cr>', { desc = 'Switch to previous buffer' })

-- search within visual selection
vim.keymap.set('x', '/', '<Esc>/\\%V')

-- Automatically add semicolon or comma at the end of the line
vim.keymap.set('n', ';;', 'A;<ESC>')
vim.keymap.set('n', ',,', 'A,<ESC>')

--- keep cursor vertically centered while scrolling
u.map('n', '<C-d>', '<C-d>zz', { desc = 'Center cursor after moving down half-page' })
u.map('n', '<C-u>', '<C-u>zz', { desc = 'Center cursor after moving up half-page' })
u.map('n', '<C-f>', '<C-f>zz', { desc = 'Center cursor after moving forward page' })
u.map('n', '<C-b>', '<C-b>zz', { desc = 'Center cursor after moving backward page' })

u.map('n', '<leader>L', ':Lazy<CR>', { desc = 'Show Lazy UI' })

-- folds
u.map('n', '<Left>', function()
    require('origami').h()
end)

u.map('n', '<Right>', function()
    require('origami').l()
end)

-- Text object
u.map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

u.map('n', '<leader>B', function()
    u.yank_file_path()
end)

local confirm_ctrl_z = function()
    local choices = { 'Yes', 'No' }

    vim.ui.select(choices, { prompt = 'Do you really want to suspend nvim ?' }, function(choice)
        if choice == 'Yes' then
            vim.cmd('stop')
        else
            print('Ctrl-Z ignored')
        end
    end)
end

u.map('n', '<C-z>', confirm_ctrl_z)

u.map('n', '<leader>D', vim.diagnostic.open_float)
