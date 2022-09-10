-- https://github.com/onsails/diaglist.nvim
local u = require('utils')
local diaglist_ok, diaglist = pcall(require, 'diaglist')

-- settings
if not diaglist_ok then
    print('Something went wrong with', diaglist)
else
    diaglist.init({
        debug = false,
        debounce_ms = 150,
    })

    -- mappings
    u.map('n', '<leader>xx', '<cmd>lua require("diaglist").open_all_diagnostics()<cr>')
end
