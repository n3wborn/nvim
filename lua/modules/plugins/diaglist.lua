-- https://github.com/onsails/diaglist.nvim
local u = require('utils')

-- settings
require('diaglist').init({
    debug = false,
    debounce_ms = 150,
})

-- mappings
u.map('n', '<leader>xx', '<cmd>lua require("diaglist").open_all_diagnostics()<cr>')
