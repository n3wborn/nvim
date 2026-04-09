require('config.options')
require('config.lsp')
require('config.keymaps')
require('config.autocommands')

-- :help vim-pack
vim.pack.add({
    { src = 'https://github.com/ibhagwan/fzf-lua' },
    { src = 'https://github.com/OXY2DEV/foldtext.nvim' },
    -- { src = 'https://github.com/SmiteshP/nvim-navic' },
    { src = 'https://github.com/b0o/SchemaStore.nvim' },
    { src = 'https://github.com/dmtrKovalenko/fff.nvim' },
    { src = 'https://github.com/folke/snacks.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/sindrets/diffview.nvim' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/kdheepak/lazygit.nvim' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = 'https://github.com/NeogitOrg/neogit' },
    {
        src = 'https://github.com/nvim-mini/mini.pairs',
        version = 'main',
    },
    {
        src = 'https://github.com/nvim-mini/mini.icons',
        version = 'main',
    },
    { src = 'https://github.com/catppuccin/nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/arborist-ts/arborist.nvim' },
    { src = 'https://github.com/folke/lazydev.nvim' },
    { src = 'https://github.com/garymjr/nvim-snippets' },
    {
        src = 'https://github.com/saghen/blink.cmp',
        version = vim.version.range('^1'),
    },

    -- { src = 'https://github.com/akinsho/git-conflict.nvim' },
    -- { src = 'https://github.com/f-person/git-blame.nvim' },
    -- { src = 'https://github.com/mfussenegger/nvim-lint' },
})

-- declare plugins and load
local function load_plugins()
    local plugin_dir = vim.fn.stdpath('config') .. '/lua/config/plugins'
    for _, file in ipairs(vim.fn.readdir(plugin_dir)) do
        if file:match('%.lua$') then
            local module = file:gsub('%.lua$', '')
            require('config.plugins.' .. module)
        end
    end
end
load_plugins()

vim.schedule(function()
    require('blink.cmp').setup({
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = {
            menu = {
                draw = {
                    columns = {
                        { 'label', 'label_description', gap = 1 },
                        { 'kind_icon' },
                        { 'kind' },
                        { 'source_name', gap = 1 },
                    },
                },
            },
            ghost_text = {
                enabled = false,
            },
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
        },
        keymap = {
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-y>'] = { 'select_and_accept', 'fallback' },
            ['<C-e>'] = { 'cancel', 'fallback' },

            ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
            ['<CR>'] = { 'select_and_accept', 'fallback' },
            ['<Esc>'] = { 'cancel', 'hide_documentation', 'fallback' },

            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        sources = {
            default = { 'lsp', 'path', 'buffer', 'lazydev', 'snippets' },
            min_keyword_length = 0,
            providers = {
                snippets = {
                    max_items = 3,
                },
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                },
                buffer = {
                    score_offset = -3,
                    opts = {
                        -- get all buffers, even ones like neo-tree
                        -- get_bufnrs = vim.api.nvim_list_bufs,
                        -- or (recommended) filter to only "normal" buffers
                        get_bufnrs = function()
                            return vim.tbl_filter(function(bufnr)
                                return vim.bo[bufnr].buftype == ''
                            end, vim.api.nvim_list_bufs())
                        end,
                    },
                },
            },
        },
        signature = { enabled = true },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
    })
end)

-- only load on insert event
-- vim.api.nvim_create_autocmd('InsertEnter', {
--     once = true,
--     callback = function()
--         vim.pack.add({
--             'https://github.com/folke/lazydev.nvim',
--             'garymjr/nvim-snippets',
--             'https://github.com/saghen/blink.cmp',
--         })
--
--         require('lazydev').setup({
--             library = {
--                 { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
--             },
--         })
--
--         require('blink.cmp').setup({
--             appearance = {
--                 nerd_font_variant = 'mono',
--             },
--             completion = {
--                 menu = {
--                     draw = {
--                         columns = {
--                             { 'label', 'label_description', gap = 1 },
--                             { 'kind_icon' },
--                             { 'kind' },
--                             { 'source_name', gap = 1 },
--                         },
--                     },
--                 },
--                 ghost_text = {
--                     enabled = false,
--                 },
--                 documentation = { auto_show = true, auto_show_delay_ms = 500 },
--             },
--             keymap = {
--                 ['<Down>'] = { 'select_next', 'fallback' },
--                 ['<Up>'] = { 'select_prev', 'fallback' },
--                 ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
--                 ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
--                 ['<C-y>'] = { 'select_and_accept', 'fallback' },
--                 ['<C-e>'] = { 'cancel', 'fallback' },
--
--                 ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
--                 ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
--                 ['<CR>'] = { 'select_and_accept', 'fallback' },
--                 ['<Esc>'] = { 'cancel', 'hide_documentation', 'fallback' },
--
--                 ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
--
--                 ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
--                 ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
--
--                 ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
--             },
--             sources = {
--                 default = { 'lsp', 'path', 'buffer', 'lazydev', 'snippets' },
--                 min_keyword_length = 0,
--                 providers = {
--                     snippets = {
--                         max_items = 3,
--                     },
--                     lazydev = {
--                         name = 'LazyDev',
--                         module = 'lazydev.integrations.blink',
--                         score_offset = 100,
--                     },
--                     buffer = {
--                         score_offset = -3,
--                         opts = {
--                             -- get all buffers, even ones like neo-tree
--                             -- get_bufnrs = vim.api.nvim_list_bufs,
--                             -- or (recommended) filter to only "normal" buffers
--                             get_bufnrs = function()
--                                 return vim.tbl_filter(function(bufnr)
--                                     return vim.bo[bufnr].buftype == ''
--                                 end, vim.api.nvim_list_bufs())
--                             end,
--                         },
--                     },
--                 },
--             },
--             signature = { enabled = true },
--             fuzzy = {
--                 implementation = 'prefer_rust_with_warning',
--             },
--         })
--     end,
-- })
