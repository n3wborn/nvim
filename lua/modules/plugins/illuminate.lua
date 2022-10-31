-- https://github.com/RRethy/vim-illuminate
local ok, illuminate = pcall(require, 'illuminate')
local u = require('utils')

if not ok then
    u.notif('Plugins :', 'Something went wrong with illuminate', vim.log.levels.WARN)
    return
else
    illuminate.configure({
        filetypes_denylist = {
            'nvim-tree',
            'telescope',
        },
    })

    vim.cmd('hi link illuminatedWord Visual')
end