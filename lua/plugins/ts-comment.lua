---@type LazyPluginSpec
return {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = { 'BufReadPost', 'BufNewFile' },
    ---@type TSContext.Config
    opts = {
        enable_autocmd = false,
    },
}
