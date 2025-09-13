return {
    'coffebar/neovim-project',
    opts = {
        projects = {
            '~/prog/git/*',
            '~/.config/*',
        },
        picker = {
            type = 'snacks',
        },
    },
    init = function()
        vim.opt.sessionoptions:append('globals')
    end,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'folke/snacks.nvim' },
        { 'Shatur/neovim-session-manager' },
    },
    lazy = false,
    priority = 100,
}
