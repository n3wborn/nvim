---@type LazyPluginSpec
return {
    'OXY2DEV/markview.nvim',
    ft = { 'markdown' },
    ---@module 'markview'
    ---@as markview.config
    opts = {
        markdown = { enable = true },
        markdown_inline = { enable = true },
        preview = { enable = true },
    },
}
