---@type LazyPluginSpec
return {
    'arborist-ts/arborist.nvim',
    event = { 'BufEnter', 'BufNewFile' },
    ---@module "arborist"
    ---@type arborist.Config
    opts = {
        prefer_wasm = false,
        update_cadence = 'daily',
        ensure_installed = {
            'lua',
            'zig',
        },
    },
}
