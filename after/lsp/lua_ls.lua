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
    on_attach = function(client, _)
        -- let stylua (via conform) handle this
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
        Lua = {
            completion = { callSnippet = 'Replace' },
            diagnostics = { globals = { 'vim', 'Snacks' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { lua_ls_root_markers1, lua_ls_root_markers2, { '.git' } }
        or vim.list_extend(vim.list_extend(lua_ls_root_markers1, lua_ls_root_markers2), { '.git' }),
}
