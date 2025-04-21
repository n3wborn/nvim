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

        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', function()
                vim.lsp.buf.definition()
            end, { buffer = ev.buf })
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
