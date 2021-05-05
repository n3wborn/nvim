-- Feline statusline
require('feline').reset_highlights()

local components = require('feline.presets').default.components
local nvim_exec = vim.api.nvim_exec

-- Remove all inactive statusline components
components.left.inactive = {}
components.mid.inactive = {}
components.right.inactive = {}

-- Get highlight of inactive statusline by parsing the style, fg and bg of VertSplit
local InactiveStatusHL = {
    fg = nvim_exec("highlight VertSplit", true):match("guifg=(#%d+)") or '#444444',
    bg = nvim_exec("highlight VertSplit", true):match("guibg=(#%d+)") or '#1E1E1E',
    style = nvim_exec("highlight VertSplit", true):match("gui=(#%d+)") or ''
}

-- Add strikethrough to inactive statusline highlight style
-- in order to have a thin line instead of the statusline
if InactiveStatusHL.style == '' then
    InactiveStatusHL.style = 'strikethrough'
else
    InactiveStatusHL.style = InactiveStatusHL.style .. ',strikethrough'
end

-- Apply the highlight to the statusline
-- by having an empty provider with the highlight
components.left.inactive[1] = {
    provider = '',
    hl = InactiveStatusHL
}

-- Setup feline.nvim
require('feline').setup{
    colors = {
        fg = '#EAEAEA',
        bg = '#151515',
        white = '#FFFFFF',
        black = '#151515'
    }
}


