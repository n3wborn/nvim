local u = require('utils')
local null_ls = require('modules.lsp.null-ls')
local tsserver = require('modules.lsp.tsserver')
local nvim_lsp = require('lspconfig')
local exec = vim.api.nvim_exec
local lsp = vim.lsp
local popup_opts = { border = 'rounded', focusable = false }

_G.global.lsp = {
    popup_opts = popup_opts,
}

vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = false,
    float = {
        show_header = true,
        source = 'if_many',
        border = 'rounded',
        focusable = false,
    },
    update_in_insert = false, -- default to false
    severity_sort = false, -- default to false
})

lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, popup_opts)
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, popup_opts)

--on_attach
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- signature
    require('lsp_signature').on_attach({
        bind = true,
        handler_opts = {
            border = 'rounded',
            virtual_text_pos = 'eol',
        },
        floating_window_above_cur_line = true,
        zindex = 50,
        --toggle_key = '<M-x>',
    })

    -- commands
    u.lua_command('LspFormatting', 'vim.lsp.buf.formatting()')
    u.lua_command('LspHover', 'vim.lsp.buf.hover()')
    u.lua_command('LspRename', 'vim.lsp.buf.rename()')
    u.lua_command('LspDiagPrev', 'vim.diagnostic.goto_prev({ popup_opts = global.lsp.popup_opts })')
    u.lua_command('LspDiagNext', 'vim.diagnostic.goto_next({ popup_opts = global.lsp.popup_opts })')
    u.lua_command('LspDiagLine', 'vim.diagnostic.open_float(0, { scope="line" })')
    u.lua_command('LspSignatureHelp', 'vim.lsp.buf.signature_help()')
    u.lua_command('LspTypeDef', 'vim.lsp.buf.type_definition()')

    -- bindings
    u.buf_map('n', '<leader>R', ':LspRename<CR>', nil, bufnr)
    u.buf_map('n', 'gy', ':LspTypeDef<CR>', nil, bufnr)
    u.buf_map('n', 'K', ':LspHover<CR>', nil, bufnr)
    u.buf_map('n', '[d', ':LspDiagPrev<CR>', nil, bufnr)
    u.buf_map('n', ']d', ':LspDiagNext<CR>', nil, bufnr)
    u.buf_map('n', '<leader>D', ':LspDiagLine<CR>', nil, bufnr)
    -- u.buf_map('i', '<C-x><C-x>', '<cmd>LspSignatureHelp<CR>', nil, bufnr)

    -- telescope
    u.buf_map('n', '<leader>lr', ':LspRef<CR>', nil, bufnr)
    u.buf_map('n', 'gd', ':LspDef<CR>', nil, bufnr)
    u.buf_map('n', 'gT', ':LspDef<CR>', nil, bufnr)
    u.buf_map('n', 'la', ':LspAct<CR>', nil, bufnr)
    u.buf_map('n', 'ls', ':LspSym<CR>', nil, bufnr)

    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

    if client.resolved_capabilities.document_formatting then
        exec('au BufWritePre * lua vim.lsp.buf.formatting_sync()', false)
    end
end

-- language servers
local servers = { 'intelephense', 'jsonls', 'yamlls', 'cssls', 'solang', 'html' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
    })
end

nvim_lsp.intelephense.setup({
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end,
})

nvim_lsp.rust_analyzer.setup({
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end,
    settings = {
        ['rust-analyzer'] = {
            assist = {
                importGranularity = 'module',
                importPrefix = 'by_self',
            },
            cargo = {
                loadOutDirsFromCheck = true,
            },
            procMacro = {
                enable = true,
            },
        },
    },
})

tsserver.setup(on_attach)
null_ls.setup(on_attach)
