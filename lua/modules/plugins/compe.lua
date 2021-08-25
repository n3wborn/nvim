-- https://github.com/hrsh7th/nvim-compe

local map = require('utils').map
local g = vim.g
local opts = { silent = true, noremap = true, expr = true }

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t "<Plug>luasnip-expand-or-jump"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif luasnip and luasnip.jumpable(-1) then
        return t "<Plug>luasnip-jump-prev"
    else
        return t "<S-Tab>"
    end
end

-- I want luasnip
require('modules.plugins.snippets')

-- set up
require('compe').setup({
    preselect = 'always',
    source = {
        nvim_lsp = true,
        path = true,
        buffer = true,
        vsnip = false,
        luasnip = true,
    },
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 30,
    documentation = {
        winhighlight = 'NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder',
        max_width = 60,
        min_width = 10,
        max_height = math.floor(vim.o.lines * 0.3),
        min_height = 1,
    },
})


-- mappings
map('i', '<Tab>', 'v:lua.tab_complete()', opts)
map('s', '<Tab>', 'v:lua.tab_complete()', opts)
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', opts)
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', opts)

map('i', '<c-y>', 'compe#confirm("<c-y>")', opts)
map('i', '<c-e>', 'compe#close("<c-e>")', opts)
map('i', '<c-space>', 'compe#complete()', opts)

-- vim completion options
vim.o.completeopt = 'menuone,noselect'
g.completion_confirm_key = ''
g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
g.completion_enable_snippet = 'luasnip'
g.completion_trigger_keyword_length = 1

-- link with autopairs
require('nvim-autopairs').setup({
    check_ts = true,
    enable_check_bracket_line = false,
})

require('nvim-autopairs.completion.compe').setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
    auto_select = false, -- auto select first item
})
