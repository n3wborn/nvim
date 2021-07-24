-- lsp

local lsp = vim.lsp
local cmd = vim.api.nvim_command

local diagnostic_opts = {
    underline = true,
    virtual_text = false,
    signs = false,
    update_in_insert = true,
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
    handler_opts = { border = 'single' },
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
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, { border = 'single' })

-- attach
local on_attach = function(client, bufnr)
    local function map(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local opts = { noremap = true, silent = true } -- mappings options

    -- attach lspkind
    require('lspkind').init(kind_cfg)

    -- attach lsp_signature
    require('lsp_signature').on_attach(signature_cfg)

    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)

    map('n', 'R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    -- formatting
    if client.resolved_capabilities.document_formatting then
        map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    if client.resolved_capabilities.document_range_formatting then
        map('v', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    end

    -- document_highlight
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=Purple
            hi LspReferenceText cterm=bold ctermbg=red guibg=Purple
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=Purple
        ]],
            false
        )
        cmd([[ autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight() ]])
        cmd([[ autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight() ]])
        cmd([[ autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references() ]])
    end

    if client.resolved_capabilities.code_lens then
        map('n', '<leader>lL', '<cmd>lua vim.lsp.codelens.run()<CR>', opts)
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
    setup_servers() -- reload installed servers
    cmd([[bufdo e]]) -- this triggers the FileType autocmd that starts the server
end
