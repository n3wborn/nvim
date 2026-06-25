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
        ---@as blink.lib.Task
        require('blink.cmp').build():pwait()
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

            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<CR>'] = { 'select_and_accept', 'fallback' },
            ['<Esc>'] = { 'cancel', 'hide_documentation', 'fallback' },

            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        sources = {
            default = { 'lsp', 'path', 'buffer', 'lazydev' },
            min_keyword_length = 0,
            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                },
                buffer = {
                    -- default to all visible buffers
                    get_bufnrs = function()
                        return vim.iter(vim.api.nvim_list_wins())
                            :map(function(win)
                                return vim.api.nvim_win_get_buf(win)
                            end)
                            :filter(function(buf)
                                return vim.bo[buf].buftype ~= 'nofile'
                            end)
                            :totable()
                    end,
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
