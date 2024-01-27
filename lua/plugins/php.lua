return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed or {}, {
                'php',
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                intelephense = {
                    cmd = { 'intelephense', '--stdio' },
                    filetypes = { 'php' },
                    root_dir = function()
                        local util = require('lspconfig.util')
                        util.root_dir('composer.json', '.git')
                    end,
                },
            },
        },
    },
    -- Ensure PHP tools are installed
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'intelephense', 'php-cs-fixer' })
        end,
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                php = { 'php_cs_fixer' },
            },
        },
        config = function(_, opts)
            require('conform.formatters.php_cs_fixer').args = function(self, ctx)
                local args = { 'fix', '$FILENAME', '--quiet', '--no-interaction', '--using-cache=no' }
                local found = vim.fs.find('.php-cs-fixer.php', { upward = true, path = ctx.dirname })[1]
                if found then
                    vim.list_extend(args, { '--config=' .. found })
                else
                    vim.list_extend(args, { '--rules=@PSR12,@Symfony' })
                end

                return args
            end

            require('conform').setup(vim.list_extend(opts or {}, opts))
        end,
    },
}
