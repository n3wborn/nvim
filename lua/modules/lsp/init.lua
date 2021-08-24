-- lsp

local bmap = require('utils').bmap
local u = require('utils')
local api = vim.api
local lsp = vim.lsp
local cmd = vim.cmd

-- lsp handlers
lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, u.popup_opts)
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, u.popup_opts)
lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    virtual_text = false,
})

local nvim_lsp = require('lspconfig')

-- custom attach
local on_attach = function(_, bufnr)
    local kind_cfg = require('utils').kind_cfg
    local signature_cfg = require('utils').signature_cfg

    require('lspkind').init(kind_cfg)
    require('lsp_signature').on_attach(signature_cfg)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    bmap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    bmap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
    bmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    bmap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    bmap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    bmap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    bmap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    bmap(bufnr, 'n', '<leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>')
    bmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    bmap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    bmap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
    bmap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    bmap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    bmap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    bmap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
    bmap(bufnr, 'n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    },
}

-- attach servers using local on_attach/capabilities
local servers = { 'intelephense', 'cssls', 'yamlls', 'jsonls', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

require('modules.lsp.tsserver')
require('modules.lsp.null-ls').setup()
