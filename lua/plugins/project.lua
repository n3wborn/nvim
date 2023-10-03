return {
    'coffebar/neovim-project',
    opts = {
        projects = {
            '~/prog/git/*',
            '~/dev/*',
            '~/da/dev/*',
            '~/.config/*',
        },
    },
    init = function()
        vim.opt.sessionoptions:append('globals')
    end,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope.nvim', tag = '0.1.0' },
        { 'Shatur/neovim-session-manager' },
    },
    priority = 100,
    keys = {
        { '<C-p>', '<cmd>Telescope neovim-project history<CR>', desc = 'Projects history' },
    },
}
