-- Remap for dealing with word wrap and adding jumps to the jumplist.
vim.keymap.set('n', 'j', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
vim.keymap.set('n', 'k', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

-- Keeping the cursor centered.
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll downwards' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll upwards' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous result' })

-- Indent while remaining in visual mode.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Formatting.
vim.keymap.set('n', 'gQ', 'mzgggqG`z<cmd>delmarks z<cr>zz', { desc = 'Format buffer' })

-- Switch between windows.
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to the left window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to the bottom window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to the top window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to the right window', remap = true })
vim.keymap.set('n', '<C-Left>', '<C-w>h', { desc = 'Move to the left window', remap = true })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { desc = 'Move to the bottom window', remap = true })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { desc = 'Move to the top window', remap = true })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { desc = 'Move to the right window', remap = true })

-- Tab navigation.

-- Poweful <esc>.
vim.keymap.set({ 'i', 's', 'n' }, '<esc>', function()
    -- TODO: adapt if needed
    ---@diagnostic disable: undefined-field
    -- if require('luasnip').expand_or_jumpable() then
    --     require('luasnip').unlink_current()
    -- end
    ---@diagnostic enable: undefined-field
    vim.cmd('noh')
    return '<esc>'
end, { desc = 'Escape, clear hlsearch, and stop snippet session', expr = true })

-- Make U opposite to u.
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })

-- Escape and save changes.
vim.keymap.set({ 's', 'i', 'n', 'v' }, '<C-s>', '<esc>:w<cr>', { desc = 'Exit insert mode and save changes' })
vim.keymap.set({ 's', 'i', 'n', 'v' }, '<C-S-s>', function()
    vim.g.skip_formatting = true
    return '<esc>:w<cr>'
end, { desc = 'Exit insert mode and save changes (without formatting)', expr = true })

-- Quickly go to the end of the line while in insert mode.
vim.keymap.set({ 'i', 'c' }, '<C-l>', '<C-o>A', { desc = 'Go to the end of the line' })

-- Package manager.
vim.keymap.set('n', '<leader>pu', '<cmd>packupdate<cr>', { desc = 'Update packages' })
vim.keymap.set('n', '<leader>ps', '<cmd>packupdate ++lockfile<cr>', { desc = 'Sync packages to lockfile' })

--- MINE

-- TODO: still needed ?
-- fix indentation
vim.keymap.set('n', '<leader>i', 'mmgg=G`m<cr>')

--- Phpcbf - Php-cs-fixer
vim.keymap.set('n', '<leader>FB', '<cmd>!phpcbf %<cr>') -- *B*eautify
vim.keymap.set('n', '<leader>FS', '<cmd>!php-cs-fixer --rules=@Symfony --using-cache=no fix %<cr>') -- *F*ix (Symfony)
vim.keymap.set('n', '<leader>FP', '<cmd>!php-cs-fixer --rules=@PSR12 --using-cache=no fix %<cr>') -- *F*ix (PSR12)
-- vim.keymap.set('n', '<leader>FF', '<cmd>!php-cs-fixer --rules=@PSR12,@Symfony --using-cache=no fix %<cr>')
vim.keymap.set('n', '<leader>FF', '<cmd>!docker compose exec php php-cs-fixer fix %<cr>')

--- Git
-- vim.keymap.set('n', '<leader>gh', ':diffget //3<cr>')
-- vim.keymap.set('n', '<leader>gu', ':diffget //2<cr>')

--- Copy-paste
vim.keymap.set('n', '<leader>Y', 'gg"+yG', { desc = 'Copy whole file' })
vim.keymap.set('n', 'D', '"_dd', { noremap = true, silent = true, desc = 'Delete line without yanking' })
vim.keymap.set('n', 'p', 'p`[=`]', { desc = 'Paste and indent' })
vim.keymap.set('n', 'P', 'P`[=`]', { desc = 'Paste before and indent' })
vim.keymap.set('v', 'p', 'p`[=`]', { desc = 'Paste and indent' })
vim.keymap.set('v', 'P', 'P`[=`]', { desc = 'Paste before and indent' })

--- Switch to previous buffer
vim.keymap.set('n', '<space><space>', '<cmd>e #<cr>', { desc = 'Switch to previous buffer' })

-- search within visual selection
vim.keymap.set('x', '/', '<Esc>/\\%V')

vim.keymap.set('n', '<leader>B', function()
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

vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        local function is_loclist()
            return vim.fn.getwininfo(vim.fn.win_getid())[1].loclist == 1
        end

        local function open_in_split(split_cmd)
            local line = vim.fn.line('.')
            local winnr = vim.fn.winnr('#') -- Fenêtre précédente

            if winnr > 0 then
                vim.cmd(winnr .. 'wincmd w')
            end

            vim.cmd(split_cmd)

            if is_loclist() then
                vim.cmd('ll ' .. line)
            else
                vim.cmd('cc ' .. line)
            end
        end

        vim.keymap.set('n', '<C-v>', function()
            open_in_split('vsplit')
        end, opts)
        vim.keymap.set('n', '<C-s>', function()
            open_in_split('split')
        end, opts)
        vim.keymap.set('n', '<C-t>', function()
            open_in_split('tabnew')
        end, opts)
    end,
    pattern = 'qf',
})
