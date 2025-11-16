-- npm i -g twiggy-language-server
---@type vim.lsp.ClientConfig
return {
    cmd = { 'twiggy-language-server', '--stdio' },
    filetypes = { 'twig' },
    root_markers = { 'composer.json', '.git' },
}
