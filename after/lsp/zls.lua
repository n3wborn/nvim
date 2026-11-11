-- https://zigtools.org/zls/install
--
-- ZLS and Zig have to be at the same version
--
-- `zls.build.json` or `zls.json` may be preferred for project wide configs
---@type vim.lsp.Config
return {
    cmd = { 'zls' },
    filetypes = { 'zig' },
    root_markers = { 'build.zig' },
    ---@type lspconfig.settings.zls
    settings = {
        zls = {
            force_autofix = true,
            warn_style = true,
        },
    },
}
