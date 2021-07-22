-- Colorscheme

local g = vim.g

-- https://github.com/marko-cerovac/material.nvim
g.material_style = 'palenight'
g.material_italic_comments = true
g.material_italic_keywords = false
g.material_italic_functions = false
g.material_italic_variables = false
g.material_contrast = true
g.material_borders = false
g.material_disable_background = true

require('material').set()

-- https://github.com/shaunsingh/nord.nvim
-- g.nord_contrast               = false
-- g.nord_borders                = true
-- g.nord_disable_background     = true
-- g.nord_cursorline_transparent = false
-- require('nord').set()
