-- https://github.com/hrsh7th/nvim-compe

local map = require('utils').map
local g = vim.g
local opts = { silent = true, noremap = true, expr = true }

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
g.completion_enable_snippet = 'vsnip'
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
