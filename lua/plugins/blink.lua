---@type LazyPluginSpec
return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
    },
    version = '1.*',
    -- build = 'cargo build --release',
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
            list = {
                selection = {
                    preselect = true,
                    auto_insert = true,
                },
            },
            menu = {
                draw = {
                    columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
                    components = {
                        item_idx = {
                            text = function(ctx)
                                return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx)
                            end,
                            highlight = 'BlinkCmpItemIdx', -- optional, only if you want to change its color
                        },
                    },
                },
            },
            trigger = {
                show_on_blocked_trigger_characters = {},
            },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                lsp = {
                    override = {
                        get_trigger_characters = function(self)
                            local trigger_characters = self:get_trigger_characters()
                            vim.list_extend(trigger_characters, { '\n', '\t', ' ' })
                            return trigger_characters
                        end,
                    },
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
}
