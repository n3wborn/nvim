return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            javascript = { { 'eslint_d', 'eslint', 'prettier_d', 'prettier' } },
            json = { 'jq' },
            lua = { 'stylua' },
            markdown = { 'markdownlint' },
            rust = { 'rustfmt' },
            sh = { 'shfmt', 'shellcheck' },
            sql = { 'sql_formatter' },
            typescript = { { 'eslint_d', 'eslint' } },
            typescriptreact = { { 'eslint_d', 'eslint' } },
            _ = { 'trim_whitespace', 'squeeze_blanks', 'trim_newlines' },
        },
    },
    format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
    },
    config = function(_, opts)
        require('conform').setup(opts)

        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = '*',
            callback = function(args)
                require('conform').format({ bufnr = args.buf })
            end,
        })
    end,
}
