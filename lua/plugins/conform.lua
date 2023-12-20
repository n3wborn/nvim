return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
        formatters_by_ft = {
            javascript = { { 'eslint_d', 'eslint', 'prettier_d', 'prettier' } },
            -- json = { 'jq' },
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
        format_on_save = function(bufnr)
            -- Disable autoformat for files in a certain path
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match('/node_modules/') or bufname:match('/vendor/') then
                return
            end
            return { async = true, timeout_ms = 500, lsp_fallback = true }
        end,
    },
    config = function(_, opts)
        vim.api.nvim_create_user_command('FormatDisable', function(args)
            -- FormatDisable! will disable formatting just for this buffer
            if args.bang then
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = 'Disable autoformat-on-save',
            bang = true,
        })

        vim.api.nvim_create_user_command('FormatEnable', function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = 'Re-enable autoformat-on-save',
        })

        require('conform.formatters.php_cs_fixer').args = function(self, ctx)
            local args = { 'fix', '$FILENAME', '--quiet', '--no-interaction', '--no-cache' }
            local found = vim.fs.find('.php-cs-fixer.php', { upward = true, path = ctx.dirname })[1]
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
