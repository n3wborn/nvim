vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    callback = function()
        vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
    end,
    desc = 'Do not auto comment on new line',
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, 'auto-cursorline')
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, 'auto-cursorline')
        end
    end,
    desc = 'Show cursor line only in active window',
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, 'auto-cursorline', cl)
            vim.wo.cursorline = false
        end
    end,
    desc = 'Show cursor line only in active window',
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
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = 'Highlight on yank',
})

vim.api.nvim_create_autocmd({ 'VimResized' }, {
    callback = function()
        vim.cmd('tabdo wincmd =')
    end,
    desc = 'Resize splits if window got resized',
})

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    desc = 'Go to last loc when opening a buffer',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = {
        'PlenaryTestPopup',
        'help',
        'lspinfo',
        'man',
        'notify',
        'qf',
        'spectre_panel',
        'startuptime',
        'tsplayground',
        'Navbuddy',
    },
    callback = function()
        vim.cmd([[
    nnoremap <silent> <buffer> q <cmd>close<CR>
    set nobuflisted
    ]])
    end,
    desc = 'Close some filetypes with <q>',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'gitcommit' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.linebreak = true
        vim.b.editorconfig = false
    end,
    desc = 'Set gitcommit config',
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
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float)

        --- quickfix
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist)

        -- inlay_hints
        if capabilities.inlayHintProvider then
            vim.keymap.set('n', '<leader>h', function()
                vim.lsp.inlay_hint(0, nil)
            end, { buffer = args.buf })
        end

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
        if capabilities.renameProvider then
            vim.keymap.set('n', '<leader>R', ':IncRename ', { buffer = args.buf })
        end

        -- show code actions available
        if capabilities.codeActionProvider then
            vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = args.buf })
        end

        -- show signature help
        if capabilities.signatureHelpProvider then
            vim.keymap.set('n', '<C-x><C-x>', vim.lsp.buf.signature_help, { buffer = args.buf })
        end
    end,
})

local conceal_ns = vim.api.nvim_create_namespace('class_conceal')
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
    desc = 'Conceal HTML class attributes. Ideal for big TailwindCSS class lists',
    group = vim.api.nvim_create_augroup('class_conceal', { clear = true }),
    pattern = { '*.tsx' },
    callback = function(event)
        local bufnr = event.buf or vim.api.nvim_get_current_buf()

        ---Ref: https://gist.github.com/mactep/430449fd4f6365474bfa15df5c02d27b
        local language_tree = vim.treesitter.get_parser(bufnr, 'tsx')
        local syntax_tree = language_tree:parse()
        local root = syntax_tree[1]:root()

        local ok, query = pcall(
            vim.treesitter.query.parse,
            'tsx',
            [[
    ((jsx_attribute
        (property_identifier) @att_name (#eq? @att_name "class")
        (string (string_fragment) @class_value)))
    ]]
        )
        if not ok then
            return
        end

        for _, captures, metadata in query:iter_matches(root, bufnr, root:start(), root:end_(), {}) do
            local start_row, start_col, end_row, end_col = captures[2]:range()
            vim.api.nvim_buf_set_extmark(bufnr, conceal_ns, start_row, start_col + 3, {
                end_line = end_row,
                end_col = end_col,
                conceal = '%', -- "…",
            })
        end
    end,
})
