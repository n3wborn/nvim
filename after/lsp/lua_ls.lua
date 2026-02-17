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
    on_attach = function(client, buf_id)
        -- disable formatting in favor of `stylua`
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- Reduce very long list of triggers for better 'mini.completion' experience
        client.server_capabilities.completionProvider.triggerCharacters = { '.', ':', '#', '(' }
    end,
    settings = {
        Lua = {
            workspace = {
                ignoreSubmodules = true,
                library = { vim.env.VIMRUNTIME },
            },
            completion = {
                callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
            diagnostics = { globals = { 'vim', 'Snacks' } },
            telemetry = { enable = false },
        },
    },
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { lua_ls_root_markers1, lua_ls_root_markers2, { '.git' } }
        or vim.list_extend(vim.list_extend(lua_ls_root_markers1, lua_ls_root_markers2), { '.git' }),
}
