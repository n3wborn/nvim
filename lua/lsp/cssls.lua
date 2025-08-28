---@type vim.lsp.Config
return {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    init_options = { provideFormatter = false },
    settings = {
        css = {
            validate = true,
            vendorPrefix = 'ignore',
            duplicateProperties = 'warning',
            zeroUnits = 'warning',
        },
    },
}
