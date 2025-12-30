---@type vim.lsp.Config
return {
    -- taken from https://github.com/chrisgrieser/.config/blob/main/nvim/lsp/lua_ls.lua
    on_attach = function(client)
        -- disable formatting in favor of `stylua`
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
        Lua = {
            completion = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                globals = { 'vim', 'Snacks' }, -- when working on nvim plugins that lack a `.luarc.json`
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            hint = {
                enable = true,
                setType = true,
                arrayIndex = 'Disable', -- too noisy
                semicolon = 'Disable', -- mostly wrong on invalid code
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
