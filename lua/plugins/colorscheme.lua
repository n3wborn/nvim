---@type LazyPluginSpec
return {
    'catppuccin/nvim',
    name = 'catppuccin',
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
