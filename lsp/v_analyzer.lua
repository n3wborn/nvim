---@type vim.lsp.Config
return {
    cmd = { '/home/stef/bin/v-analyzer' },
    filetypes = { 'v', 'vlang' },
    root_markers = { 'v.mod', '.git' },
    settings = {
        ['v-analyzer'] = {
            diagnostics = {
                enable = true,
            },
            completion = {
                enable = true,
            },
            hover = {
                enable = true,
            },
        },
    },
}
