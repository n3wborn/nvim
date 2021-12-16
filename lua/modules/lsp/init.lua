local u = require('utils')
local lsp = vim.lsp
local api = vim.api
local fn = vim.fn
local map_opts = { silent = true, noremap = true }
local border_opts = { border = 'rounded', focusable = false, scope = 'line' }

-- diagnostics
vim.diagnostic.config({ virtual_text = false, float = border_opts })
fn.sign_define('DiagnosticSignError', { text = '✗', texthl = 'DiagnosticSignError' })
fn.sign_define('DiagnosticSignWarn', { text = '!', texthl = 'DiagnosticSignWarn' })
fn.sign_define('DiagnosticSignInformation', { text = '', texthl = 'DiagnosticSignInfo' })
fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- handlers
lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, border_opts)

-- use lsp formatting if it's available (and if it's good)
-- otherwise, fall back to null-ls
local preferred_formatting_clients = { 'eslint' }
local fallback_formatting_client = 'null-ls'

local formatting = function()
    local bufnr = api.nvim_get_current_buf()
    local selected_client

    for _, client in ipairs(lsp.get_active_clients()) do
        if vim.tbl_contains(preferred_formatting_clients, client.name) then
            selected_client = client
            break
        end

        if client.name == fallback_formatting_client then
            selected_client = client
        end
    end

    if not selected_client then
        return
    end

    local params = lsp.util.make_formatting_params()
    local result, err = selected_client.request_sync('textDocument/formatting', params, 5000, bufnr)

    if result and result.result then
        lsp.util.apply_text_edits(result.result, bufnr)
    elseif err then
        vim.notify('global.lsp.formatting: ' .. err, vim.log.levels.WARN)
    end
end

global.lsp = {
    border_opts = border_opts,
    formatting = formatting,
}

--- on_attach
local on_attach = function(client, bufnr)
    require('lsp_signature').on_attach()

    --- bindings
    u.buf_map(bufnr, 'n', '<leader>R', ':lua vim.lsp.buf.rename()<CR>', map_opts)
    u.buf_map(bufnr, 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>', map_opts)
    u.buf_map(bufnr, 'n', 'K', ':lua vim.lsp.buf.hover()<CR>', map_opts)
    u.buf_map(bufnr, 'n', '[d', ':lua vim.diagnostic.goto_prev()<CR>', map_opts)
    u.buf_map(bufnr, 'n', ']d', ':lua vim.diagnostic.goto_next()<CR>', map_opts)
    u.buf_map(bufnr, 'n', '<leader>D', ':lua vim.diagnostic.open_float(nil, border_opts)<CR>', map_opts)
    u.buf_map(bufnr, 'n', '<leader>q', ':lua vim.diagnostic.setqflist()<CR>', map_opts)
    u.buf_map(bufnr, 'n', '<C-x><C-x>', ':lua vim.lsp.buf.signature_help()<CR>', map_opts)

    --- telescope
    u.buf_map(bufnr, 'n', '<leader>lr', ':Telescope lsp_references<CR>', map_opts)
    u.buf_map(bufnr, 'n', '<leader>lt', ':Telescope lsp_type_definitions<CR>', map_opts)
    u.buf_map(bufnr, 'n', '<leader>la', ':Telescope lsp_code_actions<CR>', map_opts)

    if client.resolved_capabilities.document_formatting then
        vim.cmd('autocmd BufWritePre <buffer> lua global.lsp.formatting()')
    end

    if client.resolved_capabilities.signature_help then
        vim.cmd('autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()')
    end

    require('illuminate').on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

for _, server in ipairs({
    'bashls',
    'eslint',
    'jsonls',
    'tsserver',
    'null-ls',
    'intelephense',
}) do
    require('modules.lsp.' .. server).setup(on_attach, capabilities)
end

-- suppress lspconfig messages
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match('%[lspconfig%]') then
        return
    end

    notify(msg, ...)
end
