-- indentline indentation marks
--
-- https://github.com/lukas-reineke/indent-blankline.nvim/blob/lua/

local cmd = vim.cmd
local g   = vim.g

g.indentLine_enabled = true

g.indent_blankline_char = "▏"

g.indent_blankline_use_treesitter = true
g.indent_blankline_show_current_context = true
g.indent_blankline_context_patterns = {
    'class', 'function', 'method', '^if', '^while',
    '^for', '^object', '^table', 'block', 'arguments'
}
g.indent_blankline_filetype_exclude = {"help", "terminal"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

g.indent_blankline_filetype_exclude = { 'help', 'packer' }
g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
g.indent_blankline_char_highlight = 'LineNr'

cmd [[ hi IndentBlanklineChar guifg=#aaaaaa ]]
