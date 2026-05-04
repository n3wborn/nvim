---@type LazyPluginSpec
return {
    'arborist-ts/arborist.nvim',
    event = { 'VeryLazy' },
    ---@module "arborist"
    ---@type arborist.Config
    opts = {
        prefer_wasm = false,
        update_cadence = 'daily',
        install_popular = true,
    },
}
