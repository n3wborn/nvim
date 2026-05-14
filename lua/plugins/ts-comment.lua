---@type LazyPluginSpec
return {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
        enable_autocmd = false,
    },
}
