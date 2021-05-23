-- Completion

-- set vim completion options
vim.o.completeopt = "menuone,noselect"

-- set up compe
require'compe'.setup({
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 2;
    preselect = 'enable';
    throttle_time = 200;
    source_timeout = 200;
    incomplete_delay = 400;
    allow_prefix_unmatch = false;

    source = {
        path = true;
        buffer = true;
        calc = false;
        vsnip = true;
        nvim_lsp = true;
        nvim_lua = true;
        spell = false;
        tags = true;
        treesitter = false;
        snippets_nvim = true;
    },
})

-- mappings opts
local opts = { silent = true, noremap = true, expr = true }
local map  = vim.api.nvim_set_keymap

-- mappings
map('i', '<c-y>', 'compe#confirm("<c-y>")', opts)
map('i', '<c-e>', 'compe#close("<c-e>")', opts)
map('i', '<c-space>', 'compe#complete()', opts)

-- vim completion options
vim.g.completion_confirm_key = ""
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_enable_snippet = 'snippets.nvim'
vim.g.completion_trigger_keyword_length = 2
