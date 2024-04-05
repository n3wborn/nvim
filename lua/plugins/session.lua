return {
    'stevearc/resession.nvim',
    opts = {},
    config = function(_, opts)
        vim.api.nvim_create_autocmd('VimLeavePre', {
            callback = function()
                require('resession').save('last')
            end,
        })
        require('resession').setup(opts)
    end,
}
