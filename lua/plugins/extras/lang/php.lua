return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { ensure_installed = { 'php', 'phpdoc', 'php_only' } },
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters_by_ft.php = { 'php_cs_fixer' }

            opts.formatters = opts.formatters or {}
            opts.formatters.php_cs_fixer = {
                env = { PHP_CS_FIXER_IGNORE_ENV = 1 },
            }

            -- Définir les arguments dynamiques du fixer
            require('conform.formatters.php_cs_fixer').args = function(_, ctx)
                local args = { 'fix', '$FILENAME', '--quiet', '--no-interaction', '--using-cache=no' }
                local found = nil
                local core_dir = os.getenv('CORE_DIR')
                local root_dir = nil

                if core_dir then
                    root_dir = vim.fs.find(core_dir, { type = 'directory', upward = true, path = ctx.dirname })[1]
                    if root_dir then
                        found = vim.fs.find('.php-cs-fixer.php.dist', { path = root_dir, type = 'file' })[1]
                        vim.api.nvim_echo({ { 'Found corePlugin at:\n' }, { root_dir } }, true, {})
                    end
                end

                if not found then
                    found = vim.fs.find('.php-cs-fixer.php.dist', { upward = true, path = ctx.dirname })[1]
                    if found then
                        vim.api.nvim_echo({ { 'Using fallback php-cs-fixer config:\n' }, { found } }, true, {})
                    end
                end

                if found then
                    vim.list_extend(args, { '--config=' .. found })
                else
                    vim.list_extend(args, { '--rules=@PSR12,@Symfony' })
                end

                return args
            end
        end,
    },
    {
        'mfussenegger/nvim-dap',
        opts = function()
            local dap = require('dap')
            dap.adapters.php = {
                type = 'executable',
                command = 'php-debug-adapter',
                args = {},
            }
        end,
    },
    {
        'mfussenegger/nvim-lint',
        opts = {
            linters_by_ft = {
                php = { 'phpcs' },
            },
        },
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                php = { 'php_cs_fixer' },
            },
        },
    },

    {
        'nvim-neotest/neotest',
        dependencies = {
            'olimorris/neotest-phpunit',
        },
        opts = {
            adapters = {
                ['neotest-phpunit'] = {
                    root_ignore_files = { 'tests/Pest.php' },
                },
            },
        },
    },
}
