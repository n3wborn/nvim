---@type vim.lsp.Config
return {
    settings = {
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
}

-- require('lspconfig.configs').emmylua_ls = {
-- name = 'emmylua_ls',
-- default_config = {
--     cmd = { 'emmylua_ls' },
--     filetypes = { 'lua' },
--     root_dir = require('lspconfig.util').find_git_ancestor,
--     single_file_support = true,
--     settings = {
--         Lua = {
--             runtime = {
--                 version = "LuaJIT",
--                 requirePattern = {
--                     "lua/?.lua",
--                     "lua/?/init.lua",
--                 }
--             },
--             workspace = {
--                 library = get_workspace_libraries(),
--             },
--         }
--     }
-- }
--   }
