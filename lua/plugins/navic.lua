return {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
    opts = {
        lsp = {
            auto_attach = false,
            preference = nil,
        },
        highlight = false,
        separator = '❯ ',
        depth_limit = 0,
        depth_limit_indicator = '..',
        safe_output = true,
    },
}
