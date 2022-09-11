local u = require('utils')
local colorizer_ok, colorizer = pcall(require, 'colorizer')

if not colorizer_ok then
    u.notif('Plugins :', 'Something went wrong with colorizer', vim.log.levels.WARN)
    return
else
    colorizer.setup({
        'css',
        'scss',
        'html',
        'javascript',
    })
end
