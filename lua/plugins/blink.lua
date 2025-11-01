return {
    {
        'hrsh7th/nvim-cmp',
        optional = true,
        enabled = vim.g.nvim_cmp_enabled,
    },

    {
        'saghen/blink.cmp',
        version = '*',
        -- build = "cargo build --release",
        opts_extend = {
            'sources.completion.enabled_providers',
            'sources.compat',
            'sources.default',
        },
        event = { 'InsertEnter', 'CmdlineEnter' },
        enabled = not vim.g.nvim_cmp_enabled,
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
                            { 'kind_icon', gap = 1, 'kind' },
                        },
                    },
                },

                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = {
                    enabled = vim.g.copilot_enabled or vim.g.cursor_enabled,
                },
            },
            fuzzy = {
                implementation = 'prefer_rust_with_warning',
                sorts = {
                    'score', -- Primary sort: by fuzzy matching score
                    'sort_text', -- Secondary sort: by sortText field if scores are equal
                    'label', -- Tertiary sort: by label if still tied
                },
                frecency = {
                    enabled = true,
                },
            },
            keymap = {
                preset = 'enter',
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<Up'] = { 'select_prev', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<S-Tab'] = { 'select_prev', 'fallback' },
                ['<C-y>'] = { 'select_and_accept' },
            },
            sources = {
                -- adding any nvim-cmp sources here will enable them
                -- with blink.compat
                compat = {},
                default = { 'lsp', 'path', 'snippets', 'buffer' },

                omni = {
                    module = 'blink.cmp.sources.complete_func',
                    enabled = true,
                    ---@type blink.cmp.CompleteFuncOpts
                    opts = {
                        complete_func = function()
                            return vim.bo.omnifunc
                        end,
                    },
                per_filetype = {
                    sql = { 'dadbod' },
                },
                providers = {
                    dadbod = { module = 'vim_dadbod_completion.blink' },
                    buffer = { max_items = 3 },
                },
            },
            cmdline = {
                enabled = true,
                keymap = { preset = 'cmdline' },
                completion = {
                    list = { selection = { preselect = false } },
                    menu = {
                        auto_show = function(ctx)
                            return vim.fn.getcmdtype() == ':'
                        end,
                    },
                    ghost_text = { enabled = true },
                },
            },
            signature = { enabled = true },
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

            local icons_kinds = require('custom.icons').kind
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
