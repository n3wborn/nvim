---@type vim.lsp.Config
return {
    cmd = { 'v-analyzer' },
    filetypes = { 'v', 'vsh', 'vv' },
    root_markers = { 'v.mod', '.git' },
}
