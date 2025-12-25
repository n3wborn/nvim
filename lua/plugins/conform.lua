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
            http = { 'kulala' },
            --- @todo: find a way to deal with work projects related config
            -- javascript = { { 'eslint_d', 'eslint', 'prettier_d', 'prettier' } },
            -- json = { 'jq' },
            lua = { 'stylua' },
            rust = { 'rustfmt' },
            sh = { 'shfmt', 'shellcheck' },
            sql = { 'sql_formatter' },
            typescript = { 'eslint_d', 'eslint' },
            typescriptreact = { 'eslint_d', 'eslint' },
            twig = { 'twig-cs-fixer' },
            v = { 'v' },
            ['*'] = { 'trim_whitespace', 'squeeze_blanks', 'trim_newlines' },
        },
        format_on_save = { async = false, timeout_ms = 2000, lsp_fallback = false },
        formatters = {},
    },
    config = function(_, opts)
        local ok, php_conf = pcall(require, 'plugins.conform.php')
        if ok and type(php_conf.extend) == 'function' then
            php_conf.extend(opts)
        end

        require('conform').setup(opts)
    end,
}
