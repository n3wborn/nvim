-- https://github.com/lukas-reineke/indent-blankline.nvim
local blankline_ok, blankline = pcall(require, 'indent_blankline')

if not blankline_ok then
    return
else
    blankline.setup({
        char_highlight = 'LineNr',
        char = '▏',
        filetype_exclude = { 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'terminal', '' },
        buftype_exclude = { 'terminal', 'nofile', 'quickfix' },
        use_treesitter = true,
        max_indent_increase = 1,
        show_first_indent_level = false,
        show_trailing_blankline_indent = false,
        show_current_context = true,
    })
end
