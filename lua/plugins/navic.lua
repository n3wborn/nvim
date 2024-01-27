return {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',
    opts = {
        lsp = {
            auto_attach = false,
            preference = nil,
        },
        highlight = true,
        separator = '❯ ',
        depth_limit = 0,
        depth_limit_indicator = '..',
        safe_output = true,
    },
}
