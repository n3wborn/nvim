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

-- Lazy UI
u.map('n', '<leader>L', '<cmd>Lazy<cr>')

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
u.map('n', 'D', '"_dd', { noremap = true, silent = true, desc = 'Delete line without yanking' })
u.map({ 'n', 'v' }, 'p', 'p`[=`]', { desc = 'Paste and indent' })
u.map({ 'n', 'v' }, 'P', 'P`[=`]', { desc = 'Paste before and indent' })

-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })

-- always center previous/next jumps
vim.keymap.set('n', '<C-o>', '<C-o>zz', { silent = true })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { silent = true })

--- Switch to previous buffer
u.map('n', '<space><space>', '<cmd>e #<cr>', { desc = 'Switch to previous buffer' })

-- search within visual selection
vim.keymap.set('x', '/', '<Esc>/\\%V')

u.map('n', '<leader>B', function()
    u.yank_file_path()
end)

u.map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- diagnostics
local diagnostic_goto = function(next, severity)
    return function()
        vim.diagnostic.jump({
            count = (next and 1 or -1) * vim.v.count1,
            severity = severity and vim.diagnostic.severity[severity] or nil,
            float = true,
        })
    end
end

u.map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
u.map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })

-- Autosave
u.command('ToggleAutoWrite', function()
    local value = not vim.o.autowrite
    vim.o.autowrite = value
    vim.o.autowriteall = value

    vim.notify('autowrite: ' .. (value and 'enabled' or 'disabled'), vim.log.levels.INFO)
end, {
    desc = 'Toogle Autowrite',
})

-- autosave
vim.keymap.set('n', '<leader>as', ':ToggleAutoWrite<CR>', { desc = 'ToggleAutowrite' })

-- undotree
u.map('n', '<leader>U', u.undotree)

-- restart
u.map('n', '<space>R', ':restart<CR>', { desc = 'Restart Nvim' })

u.map('n', 'ff', function()
    require('fff').find_files()
end)

u.map('n', '<space>sp', function()
    require('fff').live_grep()
end)

u.map('n', '<space>sd', function()
    local word = vim.fn.expand('<cword>')
    if word == '' then
        word = vim.fn.expand('<cWORD>')
    end

    require('fff').live_grep({ query = word })
end)
