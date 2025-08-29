---@type LazyPluginSpec
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
            markdown = { 'markdownlint-cli2', 'markdownfmt' },
            php = { 'php_cs_fixer' },
            rust = { 'rustfmt' },
            sh = { 'shfmt', 'shellcheck' },
            sql = { 'sql_formatter' },
            typescript = { 'eslint_d', 'eslint' },
            typescriptreact = { 'eslint_d', 'eslint' },
            twig = { 'twig-cs-fixer' },
            ['*'] = { 'trim_whitespace', 'squeeze_blanks', 'trim_newlines' },
        },
        --- @type conform.FormatOpts|fun(bufnr: integer)
        format_on_save = { async = false, timeout_ms = 2000, lsp_fallback = false },
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
            local args = { 'fix', '$FILENAME', '--quiet', '--no-interaction', '--using-cache=no' }
            local found = nil
            local utils = require('utils')

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

        require('conform').setup(opts)
    end,
}
