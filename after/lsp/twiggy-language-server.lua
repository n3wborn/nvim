---@type vim.lsp.Config
return {
    -- npm i -g twiggy-language-server
    cmd = { 'twiggy-language-server', '--stdio' },
    filetypes = { 'twig' },
    root_markers = { 'composer.json', '.git' },
}
