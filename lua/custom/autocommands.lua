vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    callback = function()
        vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
    end,
    desc = 'Do not auto comment on new line',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'json', 'jsonc' },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
    desc = 'Fix conceallevel for json an help files',
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    command = 'checktime',
    desc = 'Check if we need to reload the file when it changed',
})

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    group = vim.api.nvim_create_augroup('yank_highlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', priority = 250 }) --higher priority than lsp refs
    end,
    desc = 'Highlight on yank',
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
    callback = vim.schedule_wrap(function()
        vim.cmd.nohlsearch()
    end),
    desc = 'Remove hl search when enter Insert',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = {
        'checkhealth',
        'help',
        'lspinfo',
        'man',
        'Navbuddy',
        'notify',
        'oil',
        'PlenaryTestPopup',
        'qf',
        'spectre_panel',
        'startuptime',
        'trouble',
        'tsplayground',
    },
    callback = function()
        vim.cmd([[
    nnoremap <silent> <buffer> q <cmd>close<CR>
    set nobuflisted
    ]])
    end,
    desc = 'Close some filetypes with <q>',
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = {
        'docker-compose.yml',
        'docker-compose.yaml',
        'compose.yml',
        'compose.yaml',
        -- stylua: ignore
        'compose.*.yaml',
        'compose.*.yml',
    },
    command = 'set filetype=yaml.docker-compose',
})

-- https://www.reddit.com/r/neovim/comments/1fhy2xi/comment/lnea46c/
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    desc = 'navigate and preview qf-list results using <C-p> and <C-n>',
    callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        local init_bufnr = vim.fn.bufnr('#')
        vim.keymap.set('n', '<C-n>', function()
            if vim.fn.line('.') == vim.fn.line('$') then
                vim.notify('E553: No more items', vim.log.levels.ERROR)
                return
            end
            vim.cmd('wincmd p') -- jump to current displayed file
            vim.cmd(
                (vim.fn.bufnr('%') ~= init_bufnr and vim.bo.filetype ~= 'qf')
                        and ('bd | wincmd p | cn | res %d'):format(
                            math.floor(
                                (
                                    vim.o.lines
                                    - vim.o.cmdheight
                                    - (vim.o.laststatus == 0 and 0 or 1)
                                    - (vim.o.tabline == '' and 0 or 1)
                                )
                                        / 3
                                        * 2
                                    + 0.5
                            ) - 1
                        )
                    or 'cn'
            )
            vim.cmd('execute "normal! zz"')
            if vim.bo.filetype ~= 'qf' then
                vim.cmd('wincmd p')
            end
        end, opts)

        vim.keymap.set('n', '<C-p>', function()
            if vim.fn.line('.') == 1 then
                vim.notify('E553: No more items', vim.log.levels.ERROR)
                return
            end
            vim.cmd('wincmd p') -- jump to current displayed file
            vim.cmd(
                (vim.fn.bufnr('%') ~= init_bufnr and vim.bo.filetype ~= 'qf')
                        and ('bd | wincmd p | cN | res %d'):format(
                            math.floor(
                                (
                                    vim.o.lines
                                    - vim.o.cmdheight
                                    - (vim.o.laststatus == 0 and 0 or 1)
                                    - (vim.o.tabline == '' and 0 or 1)
                                )
                                        / 3
                                        * 2
                                    + 0.5
                            ) - 1
                        )
                    or 'cN'
            )
            vim.cmd('execute "normal! zz"')
            if vim.bo.filetype ~= 'qf' then
                vim.cmd('wincmd p')
            end
        end, opts)
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then
            return
        end

        if client:supports_method('textDocument/documentSymbol') then
            local navic = require('nvim-navic')
            navic.attach(client, ev.buf)
        end

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, {
                autotrigger = true,
                convert = function(item)
                    return { abbr = item.label:gsub('%b()', '') }
                end,
            })
        end

        vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, { buffer = ev.buf })
        vim.keymap.set('i', '<M-s>', vim.lsp.buf.signature_help, { buffer = ev.buf })
        vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float)
    end,
})

vim.opt.updatetime = 100
