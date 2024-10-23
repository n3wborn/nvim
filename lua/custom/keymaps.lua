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
u.map('n', '<leader><leader>', '<cmd>e #<cr>', { desc = 'Switch to previous buffer' })

--- keep cursor vertically centered while scrolling
u.map('n', '<C-d>', '<C-d>zz', { desc = 'Center cursor after moving down half-page' })
u.map('n', '<C-u>', '<C-u>zz', { desc = 'Center cursor after moving up half-page' })
u.map('n', '<C-f>', '<C-f>zz', { desc = 'Center cursor after moving forward page' })
u.map('n', '<C-b>', '<C-b>zz', { desc = 'Center cursor after moving backward page' })

--- previsou on_attach gitsigns mapping here
local gitsigns = require('gitsigns')
local jump_hunk_opts = { preview = true, navigation_message = 'f' }

u.map('n', '<leader>hn', function()
    if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
    else
        gitsigns.nav_hunk('next', jump_hunk_opts)
    end
    return 'Ignore'
end)

u.map('n', '<leader>hN', function()
    if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
    else
        gitsigns.nav_hunk('prev', jump_hunk_opts)
    end
    return 'Ignore'
end)

-- Actions
u.map('n', '<leader>hs', gitsigns.stage_hunk)
u.map('v', '<leader>hs', function()
    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end)
u.map('v', '<leader>hr', function()
    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end)
u.map('n', '<leader>hS', gitsigns.stage_buffer)
u.map('n', '<leader>hu', gitsigns.undo_stage_hunk)
u.map('n', '<leader>hR', gitsigns.reset_buffer)
u.map('n', '<leader>hr', gitsigns.reset_hunk)
u.map('n', '<leader>hp', gitsigns.preview_hunk)
u.map('n', '<leader>hb', function()
    gitsigns.blame_line({ full = true })
end)
u.map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
u.map('n', '<leader>hd', gitsigns.diffthis)
u.map('n', '<leader>hD', function()
    gitsigns.diffthis('~')
end)
u.map('n', '<leader>td', gitsigns.toggle_deleted)

-- Text object
u.map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

u.map('n', '<leader>B', function()
    u.yank_file_path()
end)

confirm_ctrl_z = function()
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
