---@type LazyPluginSpec
return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
        auto_integrations = true,
        integrations = {
            blink_cmp = {
                style = 'bordered',
            },
            blink_pairs = true,
        },
    },
}
