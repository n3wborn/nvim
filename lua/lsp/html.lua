-- npm i -g vscode-langservers-extracted
---@type vim.lsp.ClientConfig
return {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html', 'templ' },
    init_options = {
        configurationSection = { 'html', 'css', 'javascript' },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = false,
    },
    settings = {},
}
