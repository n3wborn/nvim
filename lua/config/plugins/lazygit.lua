vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_use_plenary = 0

vim.keymap.set('n', '<leader>gg', function()
    require('lazygit').lazygit()
end)
