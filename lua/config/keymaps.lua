--- Mappings
local u = require('utils')

-- source config
vim.keymap.set('n', '<leader>R', '<cmd>source $MYVIMRC<cr>')

-- fix indentation
vim.keymap.set('n', '<leader>i', 'mmgg=G`m<cr>')

-- easier windows jump
vim.keymap.set('n', '<C-Left>', '<C-w>h')
vim.keymap.set('n', '<C-Right>', '<C-w>l')
vim.keymap.set('n', '<C-Down>', '<C-w>j')
vim.keymap.set('n', '<C-Up>', '<C-w>k')

--- Resize windows
vim.keymap.set('n', '<leader>+', '<cmd>vertical resize +10<cr>')
vim.keymap.set('n', '<leader>-', '<cmd>vertical resize -10<cr>')

vim.keymap.set('n', '<space>+', '<cmd>resize +5<cr>')
vim.keymap.set('n', '<space>-', '<cmd>resize -5<cr>')

-- save in insert mode
vim.keymap.set('n', '<C-s>', '<cmd>:w<cr><esc>')

--- Phpcbf - Php-cs-fixer
--- @TODO: use a task runner
vim.keymap.set('n', '<leader>FB', '<cmd>!phpcbf %<cr>') -- *B*eautify
vim.keymap.set('n', '<leader>FS', '<cmd>!php-cs-fixer --rules=@Symfony --using-cache=no fix %<cr>') -- *F*ix (Symfony)
vim.keymap.set('n', '<leader>FP', '<cmd>!php-cs-fixer --rules=@PSR12 --using-cache=no fix %<cr>') -- *F*ix (PSR12)
-- vim.keymap.set('n', '<leader>FF', '<cmd>!php-cs-fixer --rules=@PSR12,@Symfony --using-cache=no fix %<cr>')
vim.keymap.set('n', '<leader>FF', '<cmd>!docker compose exec php php-cs-fixer fix %<cr>')

--- Git
vim.keymap.set('n', '<leader>gh', ':diffget //3<cr>')
vim.keymap.set('n', '<leader>gu', ':diffget //2<cr>')

-- Lazy UI
vim.keymap.set('n', '<leader>L', '<cmd>Lazy<cr>')

--- keep text selected after indentation
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

--- move current line up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- vim.keymap.set Ctrl-c to Escape
vim.keymap.set('i', '<C-c>', '')
vim.keymap.set('i', '<C-c>', '<Esc>')

-- close current window
vim.keymap.set('n', '<C-c><C-c>', '<cmd>close<cr>')

--- Copy-paste
vim.keymap.set('n', '<leader>Y', 'gg"+yG', { desc = 'Copy whole file' })
vim.keymap.set('n', 'D', '"_dd', { noremap = true, silent = true, desc = 'Delete line without yanking' })
-- vim.keymap.set({'n', 'v'}, 'p', 'p`[=`]', { desc = 'Paste and indent' })
-- vim.keymap.set({ 'n', 'v' }, 'P', 'P`[=`]', { desc = 'Paste before and indent' })
-- vim.keymap.set('v', 'p', 'p`[=`]', { desc = 'Paste and indent' })
-- vim.keymap.set('v', 'P', 'P`[=`]', { desc = 'Paste before and indent' })
vim.keymap.set('n', 'P', '"+P')
vim.keymap.set('n', 'p', '"+p')
-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })

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

vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })

-- Autosave
u.command('ToggleAutoWrite', function()
    local value = not vim.o.autowrite
    vim.o.autowrite = value
    vim.o.autowriteall = value

    u.info('autowrite: ' .. (value and 'enabled' or 'disabled'))
end, { desc = 'Toogle Autowrite' })

-- stylua: ignore start
vim.keymap.set('n', '<space><space>', '<cmd>e #<cr>zz', { desc = 'Switch to previous buffer' })
vim.keymap.set('x', '/', '<Esc>/\\%V', { desc = 'Search within visual selection' })
vim.keymap.set('n', '<leader>B', function() u.yank_file_path() end, { desc = 'Yank file path' })
vim.keymap.set('n', '<leader>as', ':ToggleAutoWrite<CR>', { desc = 'ToggleAutowrite' })
vim.keymap.set('n', '<leader>U', u.undotree, { desc = 'Show/Hide Undotree' })
vim.keymap.set('n', '<space>R', ':restart<CR>', { desc = 'Restart Nvim' })
-- FFF
vim.keymap.set('n', 'ff', function() require('fff').find_files() end)
vim.keymap.set('n', '<space>sp', function() require('fff').live_grep() end)
vim.keymap.set('n', '<space>sd', function() require('fff').live_grep({ query = vim.fn.expand('<cWORD>') }) end)
-- stylua: ignore end
