-- utils

local M = {}
local map_opts = { noremap = true, silent = true }

-- nvim_replace_termcodes
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- check_back_space
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- autocommands
M.nvim_create_augroups = function(definitions)
    for group_name, definition in pairs(definitions) do
        vim.cmd('augroup ' .. group_name)
        vim.cmd('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')
            vim.cmd(command)
        end
        vim.cmd('augroup END')
    end
end

-- buffer mappings
M.bmap = function(bufnr, mode, lhs, rhs, ...)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, ... or map_opts)
end

-- mappings
M.map = function(mode, lhs, rhs, ...)
    vim.api.nvim_set_keymap(mode, lhs, rhs, ... or map_opts)
end

--- https://github.com/hrsh7th/nvim-compe#how-to-use-tab-to-navigate-completion-menu
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t('<C-n>')
    elseif require('luasnip').expand_or_jumpable() then
        return t("<cmd>lua require'luasnip'.jump(1)<Cr>")
    elseif check_back_space() then
        return t('<Tab>')
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t('<C-p>')
    elseif require('luasnip').jumpable(-1) then
        return t("<cmd>lua require'luasnip'.jump(-1)<CR>")
    else
        return t('<S-Tab>')
    end
end

-- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips#peek-definition
local function preview_location_callback(_, _, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end
    vim.lsp.util.preview_location(result[1])
end

M.PeekDefinition = function()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

M.require = function(files)
    for _, file in ipairs(files) do
        require(file)
    end
end

M.kind_cfg = {
    with_text = true,
    symbol_map = {
        Text = ' ',
        Method = ' ',
        Function = ' ',
        Ctor = ' ',
        Field = ' ',
        Variable = ' ',
        Class = ' ',
        Interface = 'ﰮ ',
        Module = ' ',
        Property = ' ',
        Unit = 'ﰩ ',
        Value = ' ',
        Enum = '練',
        Keyword = ' ',
        Snippet = '﬌ ',
        Color = ' ',
        File = ' ',
        Reference = ' ',
        Folder = ' ',
        EnumMember = ' ',
        Constant = 'ﱃ ',
        Struct = ' ',
        Event = ' ',
        Operator = '璉',
        TypeParameter = ' ',
    },
}

return M
