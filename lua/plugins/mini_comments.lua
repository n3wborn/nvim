---@type LazyPluginSpec
return {
    'nvim-mini/mini.comment',
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    ---@module "mini.comment"
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type MiniComment.config
    opts = {
        options = {
            custom_commentstring = function()
                return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
            end,
        },
    },
}
