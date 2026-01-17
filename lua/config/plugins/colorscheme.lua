return {
    src = 'https://github.com/catppuccin/nvim',
    data = {
        setup = function()
            require('catppuccin').setup({
                flavour = 'mocha',
                transparent_background = true,
                styles = {
                    functions = { 'italic' },
                },
                auto_integrations = true,
            })
        end,
        -- vim.cmd('colorscheme catppuccin'),
    },
}
