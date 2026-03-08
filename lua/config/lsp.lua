---@type vim.lsp.Config
vim.lsp.config('*', {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = vim.uv.cwd()
        local root = vim.fs.root(fname, { '.git' })

        on_dir(root and vim.fs.relpath(cwd or {}, root) and cwd)
    end,
    root_markers = { '.git' },
})

local servers = {
    'intelephense',
    'lua_ls',
    -- emmylua_ls',
    'bashls',
    'twiggy-language-server',
    'zls',
    'gopls',
    'v_analyzer',
    'tsgo',
    'marksman',
    'jsonls',
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

local signs = require('config.icons').diagnostics

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
        },
    },

    severity_sort = true,
    underline = false,
    update_in_insert = true,
    float = true,
    jump = { on_jump = vim.diagnostic.open_float },
})

local lsp_group = vim.api.nvim_create_augroup('my.lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_group,
    desc = 'LSP keymaps & features',
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local bufnr = ev.buf

        local map = function(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- diagnostics
        map('n', '<leader>D', vim.diagnostic.open_float)

        -- completion
        vim.lsp.completion.enable(true, client.id, bufnr)

        -- navigation
        if client:supports_method('textDocument/definition') then
            map('n', 'gd', vim.lsp.buf.definition)
        end

        if client:supports_method('textDocument/declaration') then
            map('n', 'gD', vim.lsp.buf.declaration)
        end

        if client:supports_method('textDocument/typeDefinition') then
            map('n', '<leader>gt', vim.lsp.buf.type_definition)
        end

        if client:supports_method('textDocument/implementation') then
            map('n', 'gri', vim.lsp.buf.implementation)
        end

        if client:supports_method('callHierarchy/incomingCalls') then
            map('n', 'grI', vim.lsp.buf.incoming_calls)
        end

        -- editing
        if client:supports_method('textDocument/rename') then
            map('n', '<leader>R', vim.lsp.buf.rename)
        end

        if client:supports_method('textDocument/onTypeFormatting') then
            vim.lsp.on_type_formatting.enable()
        end

        map('i', '<M-s>', vim.lsp.buf.signature_help)

        -- -- UI extras
        -- if client:supports_method('textDocument/documentSymbol') then
        --     require('nvim-navic').attach(client, bufnr)
        -- end

        if client:supports_method('textDocument/documentColor') then
            vim.lsp.document_color.enable(true, bufnr)
        end

        if client:supports_method('textDocument/inlayHint') and vim.g.lsp_inlay_hints then
            vim.lsp.inlay_hint.enable(true)
        end

        if client:supports_method('textDocument/inlineCompletion') then
            vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
            map('i', '<C-F>', vim.lsp.inline_completion.get, { desc = 'Accept inline completion' })
            map('i', '<C-G>', vim.lsp.inline_completion.select, { desc = 'Cycle inline completion' })
        end

        if client:supports_method('textDocument/documentHighlight') then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = bufnr,
                group = lsp_group,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = bufnr,
                group = lsp_group,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach', 'DiagnosticChanged' }, {
    group = vim.api.nvim_create_augroup('StatuslineUpdate', { clear = true }),
    desc = 'Update statusline/winbar',
    callback = vim.schedule_wrap(function()
        vim.cmd.redrawstatus()
    end),
})
