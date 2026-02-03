local lua_ls_root_markers1 = {
    '.emmyrc.json',
    '.luarc.json',
    '.luarc.jsonc',
}
local lua_ls_root_markers2 = {
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
}

---@type vim.lsp.Config
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
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
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { lua_ls_root_markers1, lua_ls_root_markers2, { '.git' } }
        or vim.list_extend(vim.list_extend(lua_ls_root_markers1, lua_ls_root_markers2), { '.git' }),
}
