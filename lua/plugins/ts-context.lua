---@type LazyPluginSpec
return {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    ---@module "treesitter-context"
    ---@type TSContext.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
        max_lines = 4,
        multiline_threshold = 2,
    },
}
