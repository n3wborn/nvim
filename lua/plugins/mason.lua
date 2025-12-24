return {
    ---@type LazyPluginSpec
    {
        'williamboman/mason.nvim',
        cmd = {
            'Mason',
            'MasonUpdate',
            'MasonInstall',
            'MasonUninstall',
            'MasonUninstallAll',
            'MasonLog',
        },
        config = function()
            require('mason').setup()
        end,
    },
    ---@type LazyPluginSpec
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'rust_analyzer',
                    'intelephense',
                    'postgres-language-server',
                    'twiggy-language-server',
                },
            })
        end,
    },
}
