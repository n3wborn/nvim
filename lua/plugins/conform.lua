return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            javascript = { { 'eslint_d', 'eslint', 'prettier_d', 'prettier' } },
            json = { 'jq' },
            lua = { 'stylua' },
            markdown = { 'markdownlint' },
            php = { 'php_cs_fixer' },
            rust = { 'rustfmt' },
            sh = { 'shfmt', 'shellcheck' },
            sql = { 'sql_formatter' },
            typescript = { { 'eslint_d', 'eslint' } },
            typescriptreact = { { 'eslint_d', 'eslint' } },
            ['*'] = { 'trim_whitespace', 'squeeze_blanks', 'trim_newlines' },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
    config = function(_, opts)
        require('conform').setup(opts)

        require('conform.formatters.php_cs_fixer').args = function(ctx)
            local args = { 'fix', '$FILENAME', '--quiet', '--no-interaction', '--using-cache=no' }
            local found = vim.fs.find('.php-cs-fixer.php', { upward = true, path = ctx.dirname })[1]

            if found then
                vim.list_extend(args, { '--config=' .. found })
            else
                vim.list_extend(args, { '--rules=@PSR12,@Symfony' })
            end

            return args
        end

        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = '*',
            callback = function(args)
                require('conform').format({ bufnr = args.buf })
            end,
        })
    end,
}
