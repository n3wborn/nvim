---@type LazyPluginSpec
return {
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
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
                -- list = {
                --     selection = {
                --         preselect = true,
                --         auto_insert = true,
                --     },
                -- },
                menu = {
                    draw = {
                        columns = {
                            { 'label', 'label_description', gap = 1 },
                            { 'kind_icon', 'kind' },
                        },
                    },
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets' },
                providers = {
                    lsp = {
                        name = 'LSP',
                        module = 'blink.cmp.sources.lsp',
                        -- transform_items = function(_, items)
                        --     return vim.tbl_filter(function(item)
                        --         return item.kind ~= require('blink.cmp.types').CompletionItemKind.Keyword
                        --     end, items)
                        -- end,
                        -- override = {
                        --     get_trigger_characters = function(self)
                        --         local trigger_characters = self:get_trigger_characters()
                        --         vim.list_extend(trigger_characters, { '\n', '\t', ' ' })
                        --         return trigger_characters
                        --     end,
                        -- },
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
