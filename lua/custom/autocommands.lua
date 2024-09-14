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

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local capabilities = client.server_capabilities

        -- diagnostics
        vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float)

        --- quickfix
        vim.keymap.set('n', '<leader>q', '<cmd>Trouble diagnostics<cr>', { buffer = args.buf })

        -- show definition of current symbol
        if capabilities.definitionProvider then
            if client == 'typescript-tools' then
                vim.keymap.set('n', '<leader>gd', '<cmd>TSToolsGoToSourceDefinition<cr>', { buffer = args.buf })
            else
                vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { buffer = args.buf })
            end
        end

        -- show declaration of current symbol
        if capabilities.declarationProvider then
            vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { buffer = args.buf })
        end

        -- show definition of current type
        if capabilities.typeDefinitionProvider then
            vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, { buffer = args.buf })
        end

        -- rename current symbol
        if not capabilities.renameProvider then
            vim.notify('Provider does not have rename capability', vim.log.levels.INFO)
        else
            vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { buffer = args.buf })
        end

        -- show code actions available
        if capabilities.codeActionProvider then
            vim.keymap.set('n', '<leader>ca', function()
                require('fzf-lua').lsp_code_actions({
                    winopts = {
                        relative = 'cursor',
                        width = 0.6,
                        height = 0.6,
                        row = 1,
                        preview = { vertical = 'up:70%' },
                    },
                })
            end, { buffer = args.buf })
        end

        -- show signature help
        if capabilities.signatureHelpProvider then
            vim.keymap.set('n', '<C-x><C-x>', vim.lsp.buf.signature_help, { buffer = args.buf })
        end

        vim.keymap.set('n', '<leader>P', function()
            if not capabilities.inlayHintProvider then
                vim.notify('Inlay hints unavailable', vim.log.levels.INFO)
            end

            vim.notify('Inlay hints enabled', vim.log.levels.INFO)
            vim.lsp.inlay_hint.enable(true, { bufnr = vim.api.nvim_get_current_buf() })
        end, {})
    end,
})

vim.opt.updatetime = 100
