---@type vim.lsp.Config
return {
    -- prebuilt binary https://zigtools.org/zls/releases/
    cmd = { 'zls' },
    filetypes = { 'zig' },
    root_markers = { 'build.zig' },
    -- There are two ways to set config options:
    --   - edit your `zls.json` that applies to any editor that uses ZLS
    --   - set in-editor config options with the `settings` field below.
    --
    -- Further information on how to configure ZLS:
    -- https://zigtools.org/zls/configure/
    ---@type lspconfig.settings.zls
    settings = {
        zls = {
            -- Whether to enable build-on-save diagnostics
            --
            -- Further information about build-on save:
            -- https://zigtools.org/zls/guides/build-on-save/
            -- enable_build_on_save = true,

            -- omit the following line if `zig` is in your PATH
            zig_exe_path = '~/bin/zig-x86_64-linux-0.16.0/zig',
        },
    },
}
