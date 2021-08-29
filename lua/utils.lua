-- utils

local M = {}
local map_opts = { noremap = true, silent = true }

--[[
--
-- local functions
--
---]]

-- nvim_replace_termcodes
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- check_back_space
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips#peek-definition
local function preview_location_callback(_, _, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end
    vim.lsp.util.preview_location(result[1])
end

--[[
--
-- utils methods
--
----]]

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

M.PeekDefinition = function()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
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

-- popup windows opts
M.popup_opts = { border = 'rounded', focusable = false }

M.signature_cfg = {
    bind = true,
    floating_window = true,
    fix_pos = true,
    hint_enable = true,
    hint_scheme = 'String',
    use_lspsaga = false,
    hi_parameter = 'Search',
    max_height = 12,
    max_width = 120,
    handler_opts = popup_opts,
}

--[[
--
-- global functions
--
---]]
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
    return ...
end

return M
