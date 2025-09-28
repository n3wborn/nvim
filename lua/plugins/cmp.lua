---@type LazyPluginSpec
return {
    {
        'hrsh7th/nvim-cmp',
        version = false, -- last release is way too old
        event = 'InsertEnter',
        enabled = not vim.g.blink_enabled,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'lukas-reineke/cmp-under-comparator',
            'hrsh7th/cmp-buffer',
            'lukas-reineke/cmp-rg',
            'windwp/nvim-autopairs',
            -- 'zbirenbaum/copilot-cmp',
            'petertriho/cmp-git',
            'garymjr/nvim-snippets',
        },
        opts = function()
            vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
            local cmp = require('cmp')
            local compare = require('cmp.config.compare')
            local cmp_buffer = require('cmp_buffer')
            local icons = require('custom.icons').kinds
            ---@type cmp.SourceConfig sources
            local sources = {
                { name = 'nvim_lsp', priority = 900 },
                { name = 'buffer', max_item_count = 2, priority = 800 },
                { name = 'rg', max_item_count = 2, priority = 800 },
                { name = 'path', max_item_count = 2, priority = 500 },
                { name = 'snippets', max_item_count = 2, priority = 500 },
            }

            local comparators = {
                function(...)
                    return cmp_buffer:compare_locality(...)
                end,
                compare.offset,
                compare.exact,
                compare.score,
                require('cmp-under-comparator').under,
                compare.recently_used,
                compare.locality,
                compare.kind,
                compare.sort_text,
                compare.length,
                compare.order,
            }

            return {
                enabled = function()
                    if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt' then
                        return false
                    end
                    return true
                end,
                formatting = {
                    fields = { 'kind', 'abbr', 'menu' },
                    expandable_indicator = true,
                    format = function(entry, item)
                        item.kind = string.format('%s', icons[item.kind])
                        item.menu = ({
                            buffer = '[Buffer]',
                            lazydev = '[Lazydev]',
                            nvim_lsp = '[LSP]',
                            snippets = '[Snippets]',
                            path = '[Path]',
                            rg = '[RG]',
                            -- copilot = '[Copilot]',
                            git = '[Git]',
                        })[entry.source.name]
                        return item
                    end,
                },
                window = {
                    completion = {
                        border = vim.o.winborder,
                    },
                    documentation = {
                        border = vim.o.winborder,
                    },
                },
                ---@type cmp.SnippetConfig
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                ---@type cmp.Mapping
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete({}),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.insert,
                        select = true,
                    }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        -- elseif require('copilot.suggestion').is_visible() then
                        --     require('copilot.suggestion').accept()
                        elseif vim.snippet.active({ direction = 1 }) then
                            vim.snippet.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.snippet.active({ direction = -1 }) then
                            vim.snippet.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-e>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.abort()
                        else
                            fallback()
                        end
                    end),
                }),
                sources = sources,
                sorting = {
                    comparators = comparators,
                    priority_weight = 2,
                },
            }
        end,
        config = function(_, opts)
            local cmp = require('cmp')
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local autopairs = require('nvim-autopairs')

            autopairs.setup({ fast_wrap = {} })
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
            cmp.setup.filetype({ 'sql' }, {
                sources = {
                    { name = 'vim-dadbod-completion' },
                    { name = 'buffer' },
                },
            })

            cmp.setup.filetype({ 'gitcommit' }, {
                sources = {
                    { name = 'snippets', max_item_count = 2, priority = 800 },
                    { name = 'buffer', priority = 200 },
                    { name = 'rg', priority = 200 },
                },
            })

            -- disable when playing with typr
            cmp.setup.filetype({ 'typr' }, {
                completion = {
                    autocomplete = false,
                },
            })

            -- disable when playing with nvim-rip-substitute
            cmp.setup.filetype({ 'rip-substitute' }, {
                completion = {
                    autocomplete = false,
                },
            })
            cmp.setup(opts)
        end,
    },
}
