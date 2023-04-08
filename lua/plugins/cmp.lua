return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'lukas-reineke/cmp-under-comparator',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lua',
        'lukas-reineke/cmp-rg',
        {
            'onsails/lspkind-nvim',
            config = function()
                require('lspkind').init()
            end,
        },
    },
    config = function()
        local cmp = require('cmp')
        local cmp_buffer = require('cmp_buffer')
        local compare = require('cmp.config.compare')
        local luasnip = require('luasnip')
        local icons = {
            Array = '  ',
            Boolean = '  ',
            Class = '  ',
            Color = '  ',
            Constant = '  ',
            Constructor = '  ',
            Enum = '  ',
            EnumMember = '  ',
            Event = '  ',
            Field = '  ',
            File = '  ',
            Folder = '  ',
            Function = '  ',
            Interface = '  ',
            Key = '  ',
            Keyword = '  ',
            Method = '  ',
            Module = '  ',
            Namespace = '  ',
            Null = ' ﳠ ',
            Number = '  ',
            Object = '  ',
            Operator = '  ',
            Package = '  ',
            Property = '  ',
            Reference = '  ',
            Snippet = '  ',
            String = '  ',
            Struct = '  ',
            Text = '  ',
            TypeParameter = '  ',
            Unit = '  ',
            Value = '  ',
            Variable = '  ',
        }

        luasnip.config.setup({})

        cmp.setup({
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, item)
                    item.kind = string.format('%s', icons[item.kind])
                    item.menu = ({
                        buffer = '[Buffer]',
                        luasnip = '[Snip]',
                        nvim_lsp = '[LSP]',
                        nvim_lua = '[API]',
                        path = '[Path]',
                        rg = '[RG]',
                    })[entry.source.name]
                    return item
                end,
            },
            window = {
                completion = {
                    border = 'rounded',
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                },
                documentation = {
                    border = 'rounded',
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete({}),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'nvim_lua' },
            }, {
                {
                    name = 'buffer',
                    option = {
                        -- Complete from all visible buffers.
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
            }),
            sorting = {
                comparators = {
                    -- Sort by distance of the word from the cursor
                    -- https://github.com/hrsh7th/cmp-buffer#locality-bonus-comparator-distance-based-sorting
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
                },
            },
        })
    end,
}
