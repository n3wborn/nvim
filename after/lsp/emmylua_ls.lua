---@type vim.lsp.Config
return {
    cmd = { 'emmylua_ls' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.emmyrc.json', '.luacheckrc', '.git' },
    workspace_required = false,
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
