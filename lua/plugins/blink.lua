---@type LazyPluginSpec
return {
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            {
                'mikavilpas/blink-ripgrep.nvim',
                version = '*',
            },
        },
        version = '1.*',
        build = 'cargo build --release',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'enter',
            },
            completion = {
                keyword = { range = 'full' },
                documentation = { auto_show = true },
                accept = { auto_brackets = { enabled = true } },
                ghost_text = { enabled = true },
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
                menu = {
                    draw = {
                        columns = {
                            { 'label', 'label_description', gap = 1 },
                            { 'source_name', 'kind_icon', gap = 1, 'kind' },
                        },
                    },
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'ripgrep' },

                providers = {
                    lsp = {
                        name = 'LSP',
                        module = 'blink.cmp.sources.lsp',
                    },
                    snippets = {
                        module = 'blink.cmp.sources.snippets',
                        score_offset = -1, -- receives a -3 from top level snippets.score_offset
                        max_items = 2,
                    },
                    buffer = {
                        score_offset = -3,
                        max_items = 3,
                        opts = {
                            get_bufnrs = function()
                                return vim.tbl_filter(function(bufnr)
                                    return vim.bo[bufnr].buftype == ''
                                end, vim.api.nvim_list_bufs())
                            end,
                        },
                    },
                    ripgrep = {
                        module = 'blink-ripgrep',
                        name = 'Ripgrep',
                        -- see the full configuration below for all available options
                        ---@module "blink-ripgrep"
                        ---@type blink-ripgrep.Options
                        opts = {},
                        max_items = 3,
                    },
                },
            },
            fuzzy = {
                sorts = {
                    'exact',
                    -- defaults
                    'score',
                    'sort_text',
                },
            },
        },
    },
    {
        'madmaxieee/blink.pairs',
        -- "saghen/blink.pairs",
        event = { 'InsertEnter', 'CmdlineEnter' },
        build = 'cargo build --release',
        --- @module 'blink.pairs'
        --- @type blink.pairs.Config
        opts = {
            mappings = {
                enabled = true,
                cmdline = true,
            },
            highlights = { enabled = false },
        },
    },
}
