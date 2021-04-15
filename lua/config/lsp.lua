local nvim_lsp = require('lspconfig')

-- Default on_attach for LSP servers
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    local function buf_bind_picker(...)
        require('config.tools.telescope-nvim-utils').buf_bind_picker(bufnr, ...)
    end

    -- Telescope LSP
    buf_bind_picker('<Leader>lsd', 'lsp_document_symbols')
    buf_bind_picker('<Leader>lsw', 'lsp_workspace_symbols')
    buf_bind_picker('<Leader>ldd', 'lsp_document_diagnostics')
    buf_bind_picker('<Leader>ldw', 'lsp_workspace_diagnostics')
    buf_bind_picker('<Leader>lc', 'lsp_code_actions')

    local keys = {
        l = {
            name = '+lsp',
            s = {
                name = '+symbols',
                d = 'Document Symbols',
                w = 'Workspace Symbols'
            },
            d = {
                name = '+diagnostics',
                s = 'Show line diagnostics',
                p = 'Goto prev',
                n = 'Goto next',
                d = 'Document Diagnostics',
                w = 'Workspace Diagnostics'
            },
            c = 'Code Actions',
            w = {
                name = '+workspace',
                a = 'Add workspace folder',
                r = 'Remove workspace folder',
                l = 'List workspace folders'
            },
            D = 'Type definition',
            r = 'Rename',
        }
    }

    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

        -- Format on save
        require('utils').create_augroup({
            {'BufWritePre', '*', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
        }, 'lsp_auto_format')

        keys.l.f = 'Format'

        if client.resolved_capabilities.document_range_formatting then
            buf_set_keymap('n', '<space>lF',
                '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
                opts
            )

            keys.l.F = 'Range Format'
        end

    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap(
            'n', '<space>lf',
            '<cmd>lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})<CR>',
            opts
        )
        buf_set_keymap('n', '<space>lF',
            '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
            opts
        )

        -- Format on save
        require('utils').create_augroup({
            {
                'BufWritePre', '*',
                'lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})'
            }
        }, 'lsp_auto_format')

        keys.l.f = 'Format'
        keys.l.F = 'Range Format'
    end


    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=Blue
        hi LspReferenceText cterm=bold ctermbg=red guibg=Blue
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=Blue
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end

    -- LSP Signatures
    require('lsp_signature').on_attach()
end


-- LSP Server Configurations
local default_config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true;

    return {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end


-- LSP Servers
local servers = { 'bashls', 'rust_analyzer', 'sumneko_lua', 'pyright', 'yamlls',
                    'intelephense', 'tsserver', 'dockerls', 'html', 'jsonls' }
local lspinstall_path = vim.fn.stdpath('data') .. '/lspinstall/'


for _, server in ipairs(servers) do
    local config = default_config()

    if server == 'sumneko_lua' then
        config.cmd = {
            lspinstall_path .. 'lua/sumneko-lua-language-server',
            '-E', lspinstall_path .. 'lua/main.lua'
        }
        config.settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            },
        }
    end

    if server == "rust_analyzer" then
        config.settings = {
            ["rust-analyzer"] = {
                assist = {
                    importMergeBehavior = "last",
                    importPrefix = "by_self",
                },
                cargo = {
                    loadOutDirsFromCheck = true
                },
                procMacro = {
                    enable = true
                },
            }
        }
    end

    nvim_lsp[server].setup(config)
end

