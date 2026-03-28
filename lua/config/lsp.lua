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
    -- 'intelephense',
    'phpantom',
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

---@type vim.diagnostic.Opts
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
    desc = 'LSP Keymaps',
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local bufnr = ev.buf

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map('n', '<leader>D', vim.diagnostic.open_float, 'Line diagnostics')

        if client:supports_method('textDocument/onTypeFormatting') then
            vim.lsp.on_type_formatting.enable(true, { bufnr = bufnr })
        end

        if client:supports_method('textDocument/documentColor') then
            vim.lsp.document_color.enable(not vim.lsp.document_color.is_enabled())
        end

        if client:supports_method('textDocument/inlayHint') and vim.g.lsp_inlay_hints then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        if client:supports_method('textDocument/documentHighlight') then
            local group = vim.api.nvim_create_augroup('lsp-highlight-' .. bufnr, { clear = true })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                buffer = bufnr,
                once = true,
                callback = function()
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_del_augroup_by_name('lsp-highlight-' .. bufnr)
                end,
            })
        end
    end,
})
