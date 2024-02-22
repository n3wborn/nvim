return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed or {}, { 'twig' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                twig_language_server = {
                    cmd = { 'twiggy-language-server', '--stdio' },
                    filetypes = { 'twig.html' },
                    root_dir = function()
                        local util = require('lspconfig.util')
                        util.root_dir('composer.json', '.git')
                    end,
                },
            },
        },
    },
    -- Ensure tools are installed
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'twiggy-language-server', 'twigcs' })
        end,
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                ['twig.html'] = { 'twig-cs-fixer' },
                twig = { 'twig-cs-fixer' },
            },
        },
        config = function(_, opts)
            require('conform').setup(vim.list_extend(opts or {}, opts))
        end,
    },
}
