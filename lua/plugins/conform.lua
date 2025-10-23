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
            go = { 'gofmt' },
            --- @todo: find a way to deal with work projects related config
            -- javascript = { { 'eslint_d', 'eslint', 'prettier_d', 'prettier' } },
            -- json = { 'jq' },
            lua = { 'stylua' },
            --- @todo: add hougesen/mdsf
            markdown = { 'markdownlint-cli2', 'markdownfmt' },
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
        require('conform').setup(opts)
    end,
}
