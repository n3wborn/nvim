-- https://github.com/kylechui/nvim-surround
local u = require('utils')
local surround_ok, surround = pcall(require, 'nvim-surround')

if not surround_ok then
    u.notif('Plugins :', 'Something went wrong with nvim-surround', vim.log.levels.WARN)
    return
else
    surround.setup({
        keymaps = {
            insert = 'ys',
            visual = 'S',
            delete = 'ds',
            change = 'cs',
        },
    })
end
