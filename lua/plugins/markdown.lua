return {
    'OXY2DEV/markview.nvim',
    lazy = false, -- (already lazy-loaded)
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        Checkboxes = {
            custom = {
                {
                    match = '~',
                    text = '◕',
                    hl = 'CheckboxProgress',
                },
            },
        },
    },
    config = function(opts)
        require('markview').setup(opts)
    end,
}
