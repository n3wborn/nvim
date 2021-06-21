-- Completion

vim.o.completeopt = "menuone,noselect"

local g    = vim.g
local opts = { silent = true, noremap = true, expr = true }
local map  = vim.api.nvim_set_keymap

-- set up
require'compe'.setup({

    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 2,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    allow_prefix_unmatch = false,
    documentation = true,

    source = {
        path = true,
        buffer = true,
        calc = false,
        -- vsnip = true,
        vsnip = {kind = "﬌"},
        nvim_lsp = true,
        nvim_lua = false,
        spell = false,
        tags = true,
        treesitter = false,
        snippets_nvim = false,
    },
})

-- mappings
map('i', '<c-y>', 'compe#confirm("<c-y>")', opts)
map('i', '<c-e>', 'compe#close("<c-e>")', opts)
map('i', '<c-space>', 'compe#complete()', opts)

-- vim completion options
g.completion_confirm_key = ""
g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
g.completion_enable_snippet = 'vsnip'
g.completion_trigger_keyword_length = 2
