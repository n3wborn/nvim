---@module "blink"
---@module "lazy"

---@type LazyPluginSpec
return {
    'saghen/blink.cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
        'saghen/blink.lib',
        'folke/lazydev.nvim',
    },
    build = function()
        require('utils').lazy_await_blink_task(require('blink.cmp').build())
    end,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = {
            list = {
                -- Insert items while navigating the completion list.
                selection = { preselect = false, auto_insert = true },
                max_items = 20,
            },
            documentation = { auto_show = true },
            menu = {
                scrollbar = false,
                draw = {
                    columns = {
                        { 'label', 'label_description', gap = 1 },
                        { 'kind_icon' },
                        { 'kind' },
                        { 'source_name', gap = 1 },
                    },
                },
            },
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

            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        sources = {
            default = { 'lsp', 'path', 'buffer', 'snippets' },
            per_filetype = {
                lua = { inherit_defaults = true, 'lazydev' },
            },
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
                    opts = {
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
            implementation = 'prefer_rust',
        },
    },
    opts_extend = { 'sources.default' },
}
