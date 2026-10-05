local add_on_event = require('vim-pack').add_on_event

add_on_event({ 'BufReadPost', 'BufNewFile' }, {
    {
        src = 'nvim-treesitter/nvim-treesitter-context',
        module_name = 'treesitter-context',
        ---@module "treesitter-context"
        ---@type TSContext.Config
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            max_lines = 4,
            multiline_threshold = 2,
        },
        on_setup = function()
            vim.keymap.set('n', '[x', function()
                require('treesitter-context').go_to_context(vim.v.count1)
            end, { desc = 'TS: go to context' })
        end,
    },
})
