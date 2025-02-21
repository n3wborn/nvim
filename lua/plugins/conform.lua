return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    --- @type nil|conform.setupOpts
    opts = {
        exclude_path_patterns = {
            '/node_modules/',
            '/vendor/',
        },
        formatters_by_ft = {
            --- @todo: find a way to deal with work projects related config
            -- javascript = { { 'eslint_d', 'eslint', 'prettier_d', 'prettier' } },
            -- json = { 'jq' },
            lua = { 'stylua' },
            --- @todo: add hougesen/mdsf
            markdown = { 'markdownlint' },
            php = { 'php_cs_fixer' },
            rust = { 'rustfmt' },
            sh = { 'shfmt', 'shellcheck' },
            sql = { 'sql_formatter' },
            typescript = { 'eslint_d', 'eslint' },
            typescriptreact = { 'eslint_d', 'eslint' },
            ['twig.html'] = { 'twig-cs-fixer' },
            twig = { 'twig-cs-fixer' },
            ['*'] = { 'trim_whitespace', 'squeeze_blanks', 'trim_newlines' },
        },
        --- @type conform.FormatOpts|fun(bufnr: integer)
        format_on_save = function(bufnr)
            -- Disable autoformat for files in a certain path
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match('/node_modules/') or bufname:match('/vendor/') then
                return
            end
            return { timeout_ms = 2000, lsp_fallback = false }
        end,
        formatters = {
            php_cs_fixer = {
                env = {
                    PHP_CS_FIXER_IGNORE_ENV = 1,
                },
            },
        },
    },
    config = function(_, opts)
        require('conform.formatters.php_cs_fixer').args = function(self, ctx)
            local found
            local args = { 'fix', '$FILENAME', '--quiet', '--no-interaction', '--using-cache=no' }
            local core_dir = os.getenv('CORE_DIR')
            local root_dir = vim.fs.find(core_dir, { type = 'directory', upward = true, path = ctx.dirname })[1]

            if root_dir then
                found = vim.fs.find('.php-cs-fixer.php.dist', { path = root_dir, type = 'file' })[1]
                vim.notify('Found corePlugin at: ' .. root_dir, vim.log.levels.INFO)
            end

            if not found then
                found = vim.fs.find('.php-cs-fixer.php.dist', { upward = true, path = ctx.dirname })[1]
                vim.notify('Using fallback php-cs-fixer config', vim.log.levels.WARN)
            end

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
