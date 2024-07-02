return {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    event = { 'BufEnter' },
    version = '*',
    dependencies = {
        'SmiteshP/nvim-navic',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('barbecue').setup({
            attach_navic = true,
            show_dirname = false,
            theme = 'catpuccin-mocha',
            create_autocmd = false,
        })

        vim.api.nvim_create_autocmd({
            'WinResized',
            'BufWinEnter',
            'CursorHold',
            'InsertLeave',

            -- include this if you have set `show_modified` to `true`
            'BufModifiedSet',
        }, {
            group = vim.api.nvim_create_augroup('barbecue.updater', {}),
            callback = function()
                require('barbecue.ui').update()
            end,
        })
    end,
}
