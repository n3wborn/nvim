return {
    {
        'saghen/blink.cmp',
        version = '*',
        -- build = "cargo build --release",
        opts_extend = {
            'sources.completion.enabled_providers',
            'sources.compat',
            'sources.default',
        },
        dependencies = {
            'saghen/blink.compat',
            optional = true, -- make optional so it's only enabled if any extras need it
            opts = {},
            version = not vim.g.lazyvim_blink_main and '*',
        },
        event = { 'InsertEnter', 'CmdlineEnter' },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            completion = {
                menu = {
                    draw = {
                        columns = {
                            { 'label', 'label_description', gap = 1 },
                            { 'kind_icon', gap = 1, 'kind' },
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
                },
                providers = {
                    buffer = {
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
        config = function(_, opts)
            -- setup compat sources
            local enabled = opts.sources.default
            for _, source in ipairs(opts.sources.compat or {}) do
                opts.sources.providers[source] = vim.tbl_deep_extend(
                    'force',
                    { name = source, module = 'blink.compat.source' },
                    opts.sources.providers[source] or {}
                )
                if type(enabled) == 'table' and not vim.tbl_contains(enabled, source) then
                    table.insert(enabled, source)
                end
            end

            -- Unset custom prop to pass blink.cmp validation
            opts.sources.compat = nil
            local icons_kinds = require('config.icons').kind
            -- check if we need to override symbol kinds
            for _, provider in pairs(opts.sources.providers or {}) do
                ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
                if provider.kind then
                    local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
                    local kind_idx = #CompletionItemKind + 1

                    CompletionItemKind[kind_idx] = provider.kind
                    ---@diagnostic disable-next-line: no-unknown
                    CompletionItemKind[provider.kind] = kind_idx

                    ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
                    local transform_items = provider.transform_items
                    ---@param ctx blink.cmp.Context
                    ---@param items blink.cmp.CompletionItem[]
                    provider.transform_items = function(ctx, items)
                        items = transform_items and transform_items(ctx, items) or items
                        for _, item in ipairs(items) do
                            item.kind = kind_idx or item.kind
                            item.kind_icon = icons_kinds[item.kind_name] or item.kind_icon or nil
                        end
                        return items
                    end

                    -- Unset custom prop to pass blink.cmp validation
                    provider.kind = nil
                end
            end

            require('blink.cmp').setup(opts)
        end,
    },

    -- lazydev
    {
        'saghen/blink.cmp',
        opts = {
            sources = {
                per_filetype = {
                    lua = { inherit_defaults = true, 'lazydev' },
                },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                },
            },
        },
    },
    -- catppuccin support
    {
        'catppuccin',
        optional = true,
        opts = {
            integrations = { blink_cmp = true },
        },
    },
}
