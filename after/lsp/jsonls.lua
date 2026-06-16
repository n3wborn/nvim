---@type vim.lsp.Config
return {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    ---@type lspconfig.settings.jsonls
    settings = {
        json = {
            validate = { enable = true },
            schemas = require('schemastore').json.schemas(),
        },
    },
    init_options = {
        provideFormatter = false,
    },
}
