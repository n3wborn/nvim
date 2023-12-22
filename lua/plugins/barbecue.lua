return {
    'utilyre/barbecue.nvim',
    dependencies = {
        'SmiteshP/nvim-navic',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        attach_navic = true,
        exclude_filetypes = {
            'NvimTree',
        },
        theme = 'catpuccin-mocha',
    },
    config = function()
        require('barbecue').setup()
    end,
}
