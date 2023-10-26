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
                'neo-tree',
                'lazy',
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
            'b0o/schemastore.nvim',
            {
                'SmiteshP/nvim-navbuddy',
                cmd = 'Navbuddy',
                keys = {
                    { '<leader>N', '<cmd>Navbuddy<cr>', desc = 'nabuddy' },
                },
                dependencies = {
                    'SmiteshP/nvim-navic',
                    'MunifTanjim/nui.nvim',
                },
                opts = { lsp = { auto_attach = true } },
            },
        },
        opts = {
            inlay_hints = { enabled = true },
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
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

            --- on_attach
            local on_attach = function(client, bufnr)
                require('illuminate').on_attach(client)

                u.map('n', '<leader>h', function()
                    vim.lsp.inlay_hint(0, nil)
                end, { desc = 'Toggle Inlay Hints' })

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

            -- required servers
            for _, server in ipairs({
                'bashls',
                'dockerls',
                'docker-compose',
                'emmet',
                'eslint',
                'jsonls',
                'intelephense',
                'gopls',
                'neodev',
            }) do
                require('lsp.' .. server).setup(on_attach, capabilities)
            end
        end,
    },
}
