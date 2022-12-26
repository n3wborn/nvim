local u = require('utils')

vim.o.winwidth = 5
vim.o.winminwidth = 5
vim.o.equalalways = false

require('windows').setup()

vim.keymap.set('n', '<C-w>m', '<CMD>WindowsMaximize<CR>')
vim.keymap.set('n', '<C-w>_', '<CMD>WindowsMaximizeVertically<CR>')
vim.keymap.set('n', '<C-w>|', '<CMD>WindowsMaximizeHorizontally<CR>')
vim.keymap.set('n', '<C-w>=', '<CMD>WindowsEqualize<CR>')
