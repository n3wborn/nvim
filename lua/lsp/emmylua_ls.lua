---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                requirePattern = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- workspace = {
            --     library = get_workspace_libraries(),
            -- },
        },
    },
}
