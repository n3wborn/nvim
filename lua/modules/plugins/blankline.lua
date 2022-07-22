-- https://github.com/lukas-reineke/indent-blankline.nvim

vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_char = '▏'
vim.g.indent_blankline_filetype_exclude = { 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'terminal', '' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile', 'quickfix' }
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_max_indent_increase = 1
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true

if vim.g.indent_blankline_show_current_context then
    vim.cmd([[ hi IndentBlanklineChar guifg=#aaaaaa ]])
    vim.cmd([[
        augroup IndentBlanklineContextAutogroup
            autocmd!
            autocmd CursorMoved * IndentBlanklineRefresh
        augroup END
    ]])
end
