---@type LazyPluginSpec
return {
    'saghen/blink.cmp',
    version = '1.*',
    build = 'cargo +nightly build --release',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
        'garymjr/nvim-snippets',
        'folke/lazydev.nvim',
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
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
        fuzzy = {
            implementation = 'prefer_rust_with_warning',
        },
    },
    opts_extend = { 'sources.default' },
}
