-- heavily inspired by jose-elias-alvarez config
-- https://github.com/jose-elias-alvarez/dotfiles/blob/main/config/nvim/lua/lsp/init.lua
local u = require('utils')
local lsp = vim.lsp
local border_opts = { border = 'rounded', focusable = false, scope = 'line' }

-- diagnostics
vim.diagnostic.config({ virtual_text = false, float = border_opts })
vim.fn.sign_define('DiagnosticSignError', { text = '✗', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '!', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInformation', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

lsp.protocol.CompletionItemKind = {
    Text = ' [text]',
    Method = ' [method]',
    Function = ' [function]',
    Constructor = ' [constructor]',
    Field = 'ﰠ [field]',
    Variable = ' [variable]',
    Class = ' [class]',
    Interface = ' [interface]',
    Module = ' [module]',
    Property = ' [property]',
    Unit = ' [unit]',
    Value = ' [value]',
    Enum = ' [enum]',
    Keyword = ' [key]',
    Snippet = '﬌ [snippet]',
    Color = ' [color]',
    File = ' [file]',
    Reference = ' [reference]',
    Folder = ' [folder]',
    EnumMember = ' [enum member]',
    Constant = ' [constant]',
    Struct = ' [struct]',
    Event = '⌘ [event]',
    Operator = ' [operator]',
    TypeParameter = ' [type]',
}

-- handlers
lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, border_opts)

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local lsp_formatting = function(bufnr)
    lsp.buf.format({
        bufnr = bufnr,
        filter = function(clients)
            return vim.tbl_filter(function(client)
                if client.name == 'eslint' then
                    return true
                end
                if client.name == 'null-ls' then
                    return not u.table.some(clients, function(_, other_client)
                        return other_client.name == 'eslint'
                    end)
                end
            end, clients)
        end,
    })
end

--- on_attach
local on_attach = function(client, bufnr)
    -- commands
    u.buf_command(bufnr, 'LspHover', vim.lsp.buf.hover)
    u.buf_command(bufnr, 'LspDiagPrev', vim.diagnostic.goto_prev)
    u.buf_command(bufnr, 'LspDiagNext', vim.diagnostic.goto_next)
    u.buf_command(bufnr, 'LspDiagLine', vim.diagnostic.open_float)
    u.buf_command(bufnr, 'LspDiagQuickfix', vim.diagnostic.setqflist)
    u.buf_command(bufnr, 'LspSignatureHelp', vim.lsp.buf.signature_help)
    u.buf_command(bufnr, 'LspTypeDef', vim.lsp.buf.type_definition)
    u.buf_command(bufnr, 'LspDef', vim.lsp.buf.definition)
    u.buf_command(bufnr, 'LspRangeAct', vim.lsp.buf.range_code_action)
    u.buf_command(bufnr, 'LspAct', vim.lsp.buf.range_code_action)
    u.buf_command(bufnr, 'LspRename', function()
        vim.lsp.buf.rename()
    end)

    --- bindings
    u.buf_map(bufnr, 'n', '<leader>R', ':LspRename<CR>')
    u.buf_map(bufnr, 'n', 'gd', ':LspDef<CR>')
    u.buf_map(bufnr, 'n', 'K', ':LspHover<CR>')
    u.buf_map(bufnr, 'n', '[d', ':LspDiagPrev<CR>')
    u.buf_map(bufnr, 'n', ']d', ':LspDiagNext<CR>')
    u.buf_map(bufnr, 'n', '<leader>D', ':LspDiagLine<CR>')
    u.buf_map(bufnr, 'n', '<leader>q', ':LspDiagQuickfix<CR>')
    u.buf_map(bufnr, 'i', '<C-x><C-x>', '<cmd>LspSignatureHelp<CR>')

    --- telescope
    u.buf_map(bufnr, 'n', '<leader>lr', ':Telescope lsp_references<CR>')
    u.buf_map(bufnr, 'n', '<leader>lt', ':Telescope lsp_type_definitions<CR>')
    u.buf_map(bufnr, 'n', '<leader>la', '<cmd>LspAct<CR>')
    u.buf_map(bufnr, 'n', '<leader>lA', '<cmd>LspRangeAct<CR>')

    if client.supports_method('textDocument/formatting') then
        u.buf_command(bufnr, 'LspFormatting', function()
            lsp_formatting(bufnr)
        end)

        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            command = 'LspFormatting',
        })
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
    'rust-analyzer',
    'gopls',
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
