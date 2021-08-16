-- lsp

local bmap = require('utils').bmap
local api = vim.api
local lsp = vim.lsp
local cmd = vim.cmd

-- popup windows opts
local popup_opts = { border = 'rounded', focusable = false }

-- signature opts
local signature_cfg = {
    bind = true,
    floating_window = true,
    fix_pos = true,
    hint_enable = true,
    hint_scheme = 'String',
    use_lspsaga = false,
    hi_parameter = 'Search',
    max_height = 12,
    max_width = 120,
    handler_opts = popup_opts,
}

-- lsp handlers
lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, popup_opts)
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, popup_opts)
lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
})

-- custom attach
local on_attach = function(client, bufnr)
    -- attach lspkind
    local kind_cfg = require('utils').kind_cfg
    require('lspkind').init(kind_cfg)

    -- attach lsp_signature
    require('lsp_signature').on_attach(signature_cfg)

    bmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    bmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

    bmap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = "rounded"}})<CR>')
    bmap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = "rounded"}})<CR>')

    -- formatting
    if client.resolved_capabilities.document_formatting then
        bmap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    elseif client.resolved_capabilities.document_range_formatting then
        bmap(bufnr, 'v', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
    end

    -- document_highlight
    if client.resolved_capabilities.document_highlight then
        cmd([[ autocmd CursorHold,CursorHoldI  <buffer> lua vim.lsp.buf.document_highlight() ]])
        cmd([[ autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references() ]])
    end

    if client.resolved_capabilities.code_lens then
        bmap(bufnr, 'n', '<leader>lL', '<cmd>lua vim.lsp.codelens.run()<CR>')
        cmd([[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
    end

    -- capabilities
    local capabilities = lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        },
    }
end

-- attach servers using local on_attach/capabilities
local function setup_servers()
    local servers = { 'tsserver', 'intelephense', 'cssls', 'yamlls', 'jsonls' }
    for _, server in pairs(servers) do
        require('lspconfig')[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
end

-- setup language servers
setup_servers()

-- TODO: Fix null_ls conditional setup
local null_ls = require('modules.lsp.null-ls')
null_ls.setup(on_attach)
