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
