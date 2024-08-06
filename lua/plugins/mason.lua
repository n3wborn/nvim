return {
    'williamboman/mason.nvim',
    cmd = {
        'Mason',
        'MasonUpdate',
        'MasonInstall',
        'MasonUninstall',
        'MasonUninstallAll',
        'MasonLog',
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    'rust_analyzer',
                    'intelephense',
                    'php-cs-fixer',
                    'twigcs',
                    'twiggy-language-server',
                },
            })
        end,
    },
}