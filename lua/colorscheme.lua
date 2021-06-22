-- Colorscheme

local g   = vim.g
local cmd = vim.cmd

-- https://github.com/shaunsingh/nord.nvim
g.nord_contrast               = false
g.nord_borders                = true
g.nord_disable_background     = true
g.nord_cursorline_transparent = false
require('nord').set()
