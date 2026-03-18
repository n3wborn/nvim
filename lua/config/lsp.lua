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

local u = require('utils')
local lsp_group = vim.api.nvim_create_augroup('my.lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_group,
    desc = 'LSP keymaps & features',
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local bufnr = ev.buf

        -- diagnostics
        u.map('n', '<leader>D', vim.diagnostic.open_float)

        if client:supports_method('textDocument/onTypeFormatting') then
            vim.lsp.on_type_formatting.enable()
        end

        if client:supports_method('textDocument/documentColor') then
            vim.lsp.document_color.enable(true, bufnr)
        end

        if client:supports_method('textDocument/inlayHint') and vim.g.lsp_inlay_hints then
            vim.lsp.inlay_hint.enable(true)
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

