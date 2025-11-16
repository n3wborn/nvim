---@type vim.lsp.ClientConfig
return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            runtime = {
                version = 'LuaJIT',
                requirePattern = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                    '?/lua/?.lua',
                    '?/lua/?/init.lua',
                },
            },
            workspace = {
                library = {
                    '$VIMRUNTIME',
                    '$HOME/.local/share/nvim/lazy',
                },
                ignoreGlobs = { '**/*_spec.lua' },
            },
        },
    },
}
