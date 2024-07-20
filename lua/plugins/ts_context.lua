return {
    'nvim-treesitter',
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-context',
        },
    },
    config = function()
        vim.keymap.set('n', ']c', function()
            require('treesitter-context').go_to_context(vim.v.count1)
        end, { silent = true })
    end,
}
