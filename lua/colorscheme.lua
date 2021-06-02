-- Colorscheme

local g   = vim.g
local cmd = vim.cmd


-- gruvbox-flat
-- https://github.com/eddyekofo94/gruvbox-flat.nvim
--
-- g.gruvbox_flat_style   = "dark"
-- g.gruvbox_transparent  = true
-- g.gruvbox_dark_float   = true
-- g.gruvbox_sidebars     = { "nvim_tree", "qf", "terminal", "packer" }
-- g.gruvbox_dark_sidebar = true
--cmd('colorscheme gruvbox-flat')

-- nord
-- https://github.com/shaunsingh/nord.nvim
g.nord_contrast               = false
g.nord_borders                = true
g.nord_disable_background     = false
g.nord_cursorline_transparent = false
require('nord').set()

-- tokyonight
-- https://github.com/folke/tokyonight.nvim
-- g.tokyonight_style            = "night"
-- g.tokyonight_italic_functions = false
-- g.tokyonight_dark_sidebar     = true -- sidebar windows (ex: NvimTree) darker background
-- g.tokyonight_sidebars         = { "qf", "vista_kind", "terminal", "packer" }
-- g.tokyonight_dark_float           = true -- float windows darker background.
-- g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
-- cmd('colorscheme tokyonight')
