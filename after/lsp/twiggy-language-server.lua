---@type vim.lsp.Config
return {
    cmd = { 'twiggy-language-server', '--stdio' },
    filetypes = { 'twig', 'twig.html' },
    root_markers = { 'composer.json', '.git' },
}
