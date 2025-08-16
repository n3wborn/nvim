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
                    'basedpyright',
                    'bash_language_server',
                    'css-lsp',
                    'lua_ls',
                    'rust_analyzer',
                    'intelephense',
                    'php-cs-fixer',
                    'twigcs',
                    'twiggy-language-server',
                    'emmet_language_server',
                },
            })
        end,
    },
}
