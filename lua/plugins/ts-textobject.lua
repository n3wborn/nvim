---@type LazyPluginSpec
return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function()
        vim.g.no_plugin_maps = true
    end,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
        require('config.textobjects_keymaps').setup()
    end,
}
