return {
    'OXY2DEV/markview.nvim',
    lazy = false, -- (already lazy-loaded)
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        experimental = {
            check_rtp_message = false,
        },
    },
}
