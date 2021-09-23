-- https://github.com/L3MON4D3/LuaSnip
local function prequire(...)
    local status, lib = pcall(require, ...)
    if status then
        return lib
    end
    return nil
end

local luasnip = prequire('luasnip')

vim.api.nvim_command('hi LuasnipChoiceNodePassive cterm=italic')

require('luasnip/loaders/from_vscode').lazy_load()
