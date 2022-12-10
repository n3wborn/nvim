--- Kommentary
local ok, _ = pcall(require, 'kommentary')
local u = require('utils')

if not ok then
    u.notif('Plugins :', 'Something went wrong with kommentary', vim.log.levels.WARN)
    return
else
    vim.g.kommentary_create_default_mappings = false
    u.map('n', '<C-_>', '<Plug>kommentary_line_default', {})
    u.map('x', '<C-_>', '<Plug>kommentary_visual_default', {})
end
