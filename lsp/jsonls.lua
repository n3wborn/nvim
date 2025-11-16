-- npm i -g vscode-langservers-extracted
---@type vim.lsp.ClientConfig
return {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
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
