---@type vim.lsp.Config
return {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    init_options = { provideFormatter = false },
    root_markers = { 'package.json', '.git' },
    settings = {
        css = {
            validate = true,
            vendorPrefix = 'ignore',
            duplicateProperties = 'warning',
            zeroUnits = 'warning',
        },
        less = {
            validate = true,
        },
        scss = {
            validate = true,
        },
    },
}
