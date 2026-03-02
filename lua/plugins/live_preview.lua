---@type LazyPluginSpec
return {
    'brianhuster/live-preview.nvim',
    ft = { 'markdown' },
    cond = function()
        return vim.g.live_previewer_enabled
    end,
    dependencies = {
        'folke/snacks.nvim',
    },
}
