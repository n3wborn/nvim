-- statusline

-- https://github.com/hoob3rt/lualine.nvim
local statusline = require('lualine')

local options = { theme = 'material' }
local extensions = { 'quickfix', 'nvim-tree' }

statusline.setup({
    options = options,
    extensions = extensions,
})
