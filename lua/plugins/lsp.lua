return {
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
    { 'folke/neodev.nvim', opts = {} },
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
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'b0o/schemastore.nvim',
        },
        opts = {
            inlay_hints = { enabled = true },
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local api, lsp = vim.api, vim.lsp

            -- diagnostics
            require('lsp.diagnostics').setup()

            --- on_attach
            local on_attach = function(client)
            end

            for _, server in ipairs({
                'bash',
                'css',
                'css_modules',
                'css_variables',
                'docker',
                'docker_compose',
                'emmet',
                'eslint',
                'intelephense',
                'neodev',
                'twig',
                --- @todo: find a better way to load when really needed
                -- 'custom_elements',
                -- 'stimulus',
                -- 'tailwind',
                --- @todo: once path to generator.yml is done (best wuld be a function to determine it)
                -- 'yamlls',
            }) do
                --- @todo: refactor on_attach() as it is useless most of the time
                require('lsp.' .. server).setup(on_attach, capabilities)
            end
        end,
    },
}
