vim.filetype.add({ extension = { mdx = 'markdown.mdx', mdc = 'markdown' } })

return {
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                markdown = { 'mdformat' },
            },
            format_on_save = {
                timeout_ms = 2000,
                lsp_fallback = true,
            },
        },
    },
}
