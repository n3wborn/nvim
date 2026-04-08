---@type vim.lsp.Config
return {
    name = 'phpantom',
    cmd = { 'phpantom_lsp' },
    filetypes = { 'php' },
    root_markers = { 'composer.json', '.git' },
}
