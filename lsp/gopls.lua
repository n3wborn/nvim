---@type vim.lsp.Config
return {
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    cmd = { 'gopls' },
    root_markers = { 'go.mod', 'go.sum' },
}
