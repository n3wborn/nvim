---@type vim.lsp.Config
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            format = { enable = false },
            completion = { callSnippet = 'Replace' },
            diagnostics = { globals = { 'vim', 'Snacks' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}
