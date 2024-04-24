return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed or {}, {
                'php',
            })
        end,
    },
    -- Ensure PHP tools are installed
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'intelephense', 'php-cs-fixer' })
        end,
    },
}
