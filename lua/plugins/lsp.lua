return {
    {
        'RRethy/vim-illuminate',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            providers = {
                'lsp',
                'treesitter',
            },
            filetypes_denylist = {
                'nvimTree',
                'nvim-tree',
                'telescope',
            },
        },
        config = function(_, opts)
            require('illuminate').configure(opts)

            vim.cmd('hi link illuminatedWord Visual')
        end,
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
            config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = 'TextChanged',
        },
        keys = {
            {
                '<tab>',
                function()
                    return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
                end,
                expr = true,
                silent = true,
                mode = 'i',
            },
            {
                '<tab>',
                function()
                    require('luasnip').jump(1)
                end,
                mode = 's',
            },
            {
                '<s-tab>',
                function()
                    require('luasnip').jump(-1)
                end,
                mode = { 'i', 's' },
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'folke/neodev.nvim',
            'jose-elias-alvarez/null-ls.nvim',
            'jose-elias-alvarez/typescript.nvim',
            'b0o/schemastore.nvim',
            {
                'SmiteshP/nvim-navbuddy',
                dependencies = {
                    'SmiteshP/nvim-navic',
                    'MunifTanjim/nui.nvim',
                },
            },
        },
        config = function()
            local u = require('utils')
            local lsp = vim.lsp

            require('lsp.diagnostics').setup()

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
                Snippet = ' [snippet]',
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

            -- lsp formatting
            local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
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

                if capabilities.inlayHintProvider then
                    vim.lsp.buf.inlay_hint(bufnr, true)
                end

                if client.supports_method('textDocument/formatting') then
                    local formatting_cb = function()
                        lsp_formatting(bufnr)
                    end
                    u.buf_command(bufnr, 'LspFormatting', formatting_cb)
                    u.buf_map(bufnr, 'x', '<CR>', formatting_cb)

                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
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

                -- hover current symbol details
                if capabilities.hoverProvider then
                    u.buf_command(bufnr, 'LspHover', function()
                        vim.lsp.buf.hover()
                    end)

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

                -- show current context in statusline/winbar
                if client.server_capabilities.documentSymbolProvider then
                    require('nvim-navbuddy').attach(client, bufnr)
                end
            end

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- required servers
            for _, server in ipairs({
                'bashls',
                'dockerls',
                'docker-compose',
                'emmet',
                'eslint',
                'jsonls',
                'typescript',
                'null-ls',
                'intelephense',
                'gopls',
                'neodev',
            }) do
                require('lsp.' .. server).setup(on_attach, capabilities)
            end
        end,
    },
}
