-- https://github.com/hrsh7th/nvim-compe

vim.opt.completeopt = "menuone,noselect"

local g    = vim.g
local opts = { silent = true, noremap = true, expr = true }
local map  = vim.api.nvim_set_keymap

-- set up
require'compe'.setup({
    preselect = 'always',
    source = {
        nvim_lsp = true,
        path = true,
        buffer = true,
        vsnip = true,
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
g.completion_trigger_keyword_length = 1
