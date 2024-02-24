return {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
        providers = {
            'lsp',
            'treesitter',
        },
        filetypes_denylist = {
            'nvimTree',
            'nvim-tree',
            'neo-tree',
            'lazy',
            'telescope',
        },
    },
    config = function(_, opts)
        require('illuminate').configure(opts)

        vim.cmd('hi link illuminatedWord Visual')
    end,
}
