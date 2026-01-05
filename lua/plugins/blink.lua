return {
    {
        'saghen/blink.cmp',
        version = '*',
        -- build = "cargo build --release",
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'moyiz/blink-emoji.nvim',
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
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
                documentation = {
                    auto_show = true,
                },
            },
            keymap = {
                ['<Down>'] = { 'select_next', 'fallback_to_mappings' },
                ['<Up>'] = { 'select_prev', 'fallback_to_mappings' },
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
                default = {
                    'lsp',
                    'path',
                    'buffer',
                    'emoji',
                    per_filetype = {
                        lua = { inherit_defaults = true, 'lazydev' },
                    },
                },
                providers = {
                    emoji = {
                        module = 'blink-emoji',
                        name = 'Emoji',
                        score_offset = 15,
                        opts = {
                            insert = true, -- Insert emoji (default) or complete its name
                            ---@type string|table|fun():table
                            trigger = function()
                                return { ':' }
                            end,
                        },
                        should_show_items = function()
                            return vim.tbl_contains({ 'gitcommit', 'markdown' }, vim.o.filetype)
                        end,
                    },
                    lsp = {
                        min_keyword_length = 0,
                        score_offset = 90,
                    },
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                    buffer = {
                        score_offset = 15,
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
    },
}
