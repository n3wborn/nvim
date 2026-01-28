return {
    src = 'https://github.com/kdheepak/lazygit.nvim',
    data = {
        setup = function()
            vim.g.lazygit_floating_window_winblend = 0
            vim.g.lazygit_floating_window_use_plenary = 0
        end,
    },
}
