-- https://github.com/hrsh7th/nvim-compe

local api = vim.api
local fn = vim.fn
local g = vim.g
local o = vim.opt
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true, expr = true }

local t = function(str)
    return api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = fn.col('.') - 1
    return col == 0 or fn.getline('.'):sub(col, col):match('%s') ~= nil
end

--- https://github.com/hrsh7th/nvim-compe#how-to-use-tab-to-navigate-completion-menu
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if fn.pumvisible() == 1 then
        return t('<C-n>')
    elseif require('luasnip').expand_or_jumpable() then
        return t("<cmd>lua require'luasnip'.jump(1)<Cr>")
    elseif check_back_space() then
        return t('<Tab>')
    else
        return fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if fn.pumvisible() == 1 then
        return t('<C-p>')
    elseif require('luasnip').jumpable(-1) then
        return t("<cmd>lua require'luasnip'.jump(-1)<CR>")
    else
        return t('<S-Tab>')
    end
end

-- set up
require('compe').setup({
    preselect = 'always',
    source = {
        nvim_lsp = true,
        path = true,
        buffer = true,
        vsnip = true,
        luasnip = true,
    },
})

-- mappings
map('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

map('i', '<c-y>', 'compe#confirm("<c-y>")', opts)
map('i', '<c-e>', 'compe#close("<c-e>")', opts)
map('i', '<c-space>', 'compe#complete()', opts)

-- vim completion options
o.completeopt = 'menuone,noselect'
g.completion_confirm_key = ''
g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
g.completion_enable_snippet = 'vsnip'
g.completion_trigger_keyword_length = 1
