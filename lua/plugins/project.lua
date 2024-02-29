return {
    'coffebar/neovim-project',
    opts = {
        projects = {
            '~/.config/nvim',
            '~/projects/qk-safety',
            '~/projects/qk-safety/plugins/*',
            '~/projects/qk-safety-lcsb',
            '~/projects/qk-safety-lcsb/plugins/*',
            '~/.local/share/nvim/lazy/*',
            '~/div/*',
        },
    },
    init = function()
        vim.opt.sessionoptions:append('globals')
    end,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope.nvim', tag = '0.1.5' },
        { 'Shatur/neovim-session-manager' },
    },
    lazy = false,
    priority = 100,
    keys = {
        { '<C-p>', '<cmd>Telescope neovim-project history<CR>', desc = 'Projects history' },
        { '<C-P>', '<cmd>Telescope neovim-project discover<CR>', desc = 'Projects discover' },
    },
}
