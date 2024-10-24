return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
        formatters_by_ft = {
            --- @todo: find a way to deal with work projects related config
            -- javascript = { { 'eslint_d', 'eslint', 'prettier_d', 'prettier' } },
            -- json = { 'jq' },
            lua = { 'stylua' },
            --- @todo: add hougesen/mdsf
            markdown = { 'markdownlint' },
            rust = { 'rustfmt' },
            sh = { 'shfmt', 'shellcheck' },
            sql = { 'sql_formatter' },
            typescript = { { 'eslint_d', 'eslint' } },
            typescriptreact = { { 'eslint_d', 'eslint' } },
            ['twig.html'] = { 'twig-cs-fixer' },
            twig = { 'twig-cs-fixer' },
            ['*'] = { 'trim_whitespace', 'squeeze_blanks', 'trim_newlines' },
        },
        format_on_save = function(bufnr)
            -- Disable autoformat for files in a certain path
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match('/node_modules/') or bufname:match('/vendor/') then
                return
            end
            return { async = false, timeout_ms = 500, lsp_fallback = false }
        end,
    },
    config = function(_, opts)
        require('conform.formatters.php_cs_fixer').args = function(self, ctx)
            local args = { 'fix', '$FILENAME', '--quiet', '--no-interaction', '--using-cache=no' }
            local found = vim.fs.find('.php-cs-fixer.php.dist', { upward = true, path = ctx.dirname })[1]
            if found then
                vim.list_extend(args, { '--config=' .. found })
            else
                vim.list_extend(args, { '--rules=@PSR12,@Symfony' })
            end

            return args
        end

        require('conform').setup(opts)
    end,
}
