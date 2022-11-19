-- heavily inspired by jose-elias-alvarez config
-- https://github.com/jose-elias-alvarez/dotfiles/blob/main/config/nvim/lua/lsp/init.lua
local u = require('utils')
local lsp = vim.lsp
local border_opts = { border = 'rounded', focusable = false, scope = 'line' }

-- lsp comp items
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

-- lsp formatting
local lsp_formatting = function(bufnr)
    local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

    lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
            if client.name == 'eslint' then
                return true
            end

            if client.name == 'null-ls' then
                return not u.table.some(clients, function(_, other_client)
                    return other_client.name == 'eslint'
                end)
            end
        end,
    })
end

--- on_attach
local on_attach = function(client, bufnr)
    require('illuminate').on_attach(client)

    -- capabilities
    local capabilities = client.server_capabilities

    -- lsp format
    if capabilities.documentFormattingProvider then
        u.buf_command(bufnr, 'LspFormatting', function()
            lsp_formatting(bufnr)
        end)

        local augroup = 'auto_format_' .. bufnr
        vim.api.nvim_create_augroup(augroup, { clear = true })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            command = 'LspFormatting',
        })
    end

    -- show definition of current symbol
    if capabilities.definitionProvider then
        u.buf_command(bufnr, 'LspDef', function()
            vim.lsp.buf.definition()
        end)

        u.buf_map(bufnr, 'n', '<leader>gd', '<cmd>LspDef<CR>')
    end

    -- show declaration of current symbol
    if capabilities.declarationProvider then
        u.buf_command(bufnr, 'LspDef', function()
            vim.lsp.buf.declaration()
        end)

        u.buf_map(bufnr, 'n', '<leader>gD', '<cmd>LspDef<CR>')
    end

    -- show definition of current type
    if capabilities.typeDefinitionProvider then
        u.buf_command(bufnr, 'LspTypeDef', function()
            vim.lsp.buf.type_definition()
        end)

        u.buf_map(bufnr, 'n', '<leader>lt', '<cmd>LspTypeDef<CR>')
        -- u.buf_map(bufnr, 'n', '<leader>lt', ':Telescope lsp_type_definitions<CR>')
    end

    -- show implementation fo current symbol
    if capabilities.implementationProvider then
        u.buf_command(bufnr, 'LspImplementations', function()
            vim.lsp.buf.implementation()
        end)

        u.buf_map(bufnr, 'n', '<leader>li', '<cmd>LspImplementations<CR>')
    end

    -- hover current symbol details
    if capabilities.hoverProvider then
        if client.name == 'rust-analyzer' then
            -- hover_with_actions has been deprecated from rust-tools settings
            u.buf_command(bufnr, 'LspHover', ':RustHoverActions<CR>')
        else
            u.buf_command(bufnr, 'LspHover', function()
                vim.lsp.buf.hover()
            end)
        end

        u.buf_map(bufnr, 'n', 'K', '<cmd>LspHover<CR>')
    end

    -- rename current symbol
    if capabilities.renameProvider then
        u.buf_command(bufnr, 'LspRename', function()
            vim.lsp.buf.rename()
        end)

        u.buf_map(bufnr, 'n', '<leader>R', ':LspRename<CR>')
    end

    -- show code actions available
    if capabilities.codeActionProvider then
        u.buf_command(bufnr, 'LspAct', function()
            vim.lsp.buf.code_action()
        end)

        u.buf_map(bufnr, 'n', '<leader>la', '<cmd>LspAct<CR>')
    end

    -- References of current symbol
    if capabilities.referencesProvider then
        u.buf_command(bufnr, 'LspRefs', function()
            vim.lsp.buf.references()
        end)

        u.buf_map(bufnr, 'n', '<leader>lr', '<cmd>LspRefs<CR>')
        -- u.buf_map(bufnr, 'n', '<leader>lr', ':Telescope lsp_references<CR>')
    end

    -- show signature help
    if capabilities.signatureHelpProvider then
        u.buf_command(bufnr, 'LspSignatureHelp', function()
            vim.lsp.buf.signature_help()
        end)
        u.buf_map(bufnr, 'i', '<C-x><C-x>', '<cmd>LspSignatureHelp<CR>')
    end

    -- diagnostics
    u.buf_command(bufnr, 'LspDiagPrev', vim.diagnostic.goto_prev)
    u.buf_map(bufnr, 'n', '[d', ':LspDiagPrev<CR>')

    u.buf_command(bufnr, 'LspDiagNext', vim.diagnostic.goto_next)
    u.buf_map(bufnr, 'n', ']d', ':LspDiagNext<CR>')

    u.buf_command(bufnr, 'LspDiagLine', vim.diagnostic.open_float)
    u.buf_map(bufnr, 'n', '<leader>D', ':LspDiagLine<CR>')

    --- quickfix
    u.buf_command(bufnr, 'LspDiagQuickfix', vim.diagnostic.setqflist)
    u.buf_map(bufnr, 'n', '<leader>q', ':LspDiagQuickfix<CR>')
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- required servers
for _, server in ipairs({
    'bashls',
    'eslint',
    'jsonls',
    'tsserver',
    'null-ls',
    'intelephense',
    'rust-analyzer',
    'gopls',
    'neodev',
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
