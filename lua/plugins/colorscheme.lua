---@type LazyPluginSpec
return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
        transparent_background = true,
        float = {
            transparent = false,
        },
        auto_integrations = true,
        integrations = {
            blink_cmp = {
                style = 'bordered',
            },
            blink_pairs = true,
        },
    },
}
