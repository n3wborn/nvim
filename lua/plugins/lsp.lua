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
            local lspconfig = require('lspconfig')
            require('lsp.diagnostics').setup()

            for _, server in ipairs({
                'bashls',
                'cssls',
                'cssmodules_ls',
                'css_variables',
                'dockerls',
                'docker_compose_language_service',
                'intelephense',
                --- @todo: find a better way to load when really needed
                -- 'custom_elements_ls',
                -- jsonls
                -- 'stimulus_ls',
            }) do
                lspconfig[server].setup({ capabilities = capabilities })
            end

            for _, server in ipairs({
                'emmet',
                'eslint',
                'neodev',
                'twig',
                -- 'tailwind',
                --- @todo: once path to generator.yml is done (best wuld be a function to determine it)
                -- 'yamlls',
            }) do
                require('lsp.' .. server).setup(capabilities)
            end
        end,
    },
}
