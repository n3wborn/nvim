-- lsp

local lsp = vim.lsp
local bmap = require('utils').bmap
local cmd = vim.cmd

local diagnostic_opts = {
    underline = true,
    virtual_text = false,
    signs = false,
    update_in_insert = true,
}

local popup_opts = {
    border = 'rounded',
    focusable = false,
}

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

local kind_cfg = {
    with_text = true,
    symbol_map = {
        Text = ' ',
        Method = ' ',
        Function = ' ',
        Ctor = ' ',
        Field = ' ',
        Variable = ' ',
        Class = ' ',
        Interface = 'ﰮ ',
        Module = ' ',
        Property = ' ',
        Unit = 'ﰩ ',
        Value = ' ',
        Enum = '練',
        Keyword = ' ',
        Snippet = '﬌ ',
        Color = ' ',
        File = ' ',
        Reference = ' ',
        Folder = ' ',
        EnumMember = ' ',
        Constant = 'ﱃ ',
        Struct = ' ',
        Event = ' ',
        Operator = '璉',
        TypeParameter = ' ',
    },
}

-- handlers config
lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, diagnostic_opts)
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, popup_opts)

-- attach
local on_attach = function(client, bufnr)
    -- attach lspkind
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
    end

    if client.resolved_capabilities.document_range_formatting then
        bmap(bufnr, 'v', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
    end

    -- document_highlight
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
            hi LspReferenceRead cterm=bold ctermbg=Red guibg=Purple
            hi LspReferenceText cterm=bold ctermbg=Red guibg=Purple
            hi LspReferenceWrite cterm=bold ctermbg=Red guibg=Purple
        ]],
            false
        )
        cmd([[ autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight() ]])
        -- cmd([[ autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight() ]])
        cmd([[ autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references() ]])
    end

    if client.resolved_capabilities.code_lens then
        bmap(bufnr, 'n', '<leader>lL', '<cmd>lua vim.lsp.codelens.run()<CR>')
        cmd([[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
    end
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

local function setup_servers()
    require('lspinstall').setup()
    local servers = require('lspinstall').installed_servers()
    for _, server in pairs(servers) do
        require('lspconfig')[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require('lspinstall').post_install_hook = function()
    setup_servers()
    cmd([[bufdo e]])
end
