---@type LazyPluginSpec
return {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
        {
            '[x',
            function()
                require('treesitter-context').go_to_context(vim.v.count1)
            end,
            desc = 'TS: go to context',
        },
    },
    ---@module "treesitter-context"
    ---@type TSContext.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
        max_lines = 4,
        multiline_threshold = 2,
    },
}
