local servers = {
    'bashls',
    'gopls',
    'jsonls',
    -- emmylua_ls',
    'lua_ls',
    -- 'kotlin_lsp',
    'kmp_lsp',
    'marksman',
    'mpls',
    'oxfmt',
    -- 'intelephense',
    'phpantom',
    'tsgo',
    'taplo',
    'twiggy-language-server',
    'v_analyzer',
    'zls',
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
    -- TODO: choose which one is better
    -- update_in_insert = false,
    float = true,
    jump = { on_jump = vim.diagnostic.open_float },
    -- TODO: choose lines or text
    virtual_lines = {
        current_line = true,
        severity = {
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.ERROR,
        },
    },
    -- virtual_text = {
    --     current_line = true,
    --     severity = {
    --         vim.diagnostic.severity.WARN,
    --         vim.diagnostic.severity.ERROR,
    --     },
    -- },
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
