---@type LazyPluginSpec
return {
    'Mirsmog/real-icons.nvim',
    build = ':RealIconsInstallPack material',
    opts = {
        pack = 'material',
        integrations = {
            fzf_lua = true,
            lualine = true,
            oil = true,
            snacks_picker = true,
        },
    },
}
