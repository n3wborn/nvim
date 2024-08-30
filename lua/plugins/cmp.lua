return {
    'yioneko/nvim-cmp',
    branch = 'perf',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'lukas-reineke/cmp-under-comparator',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lua',
        'lukas-reineke/cmp-rg',
        'windwp/nvim-autopairs',
    },
    opts = function()
        local cmp = require('cmp')
        local compare = require('cmp.config.compare')
        local cmp_buffer = require('cmp_buffer')
        local icons = require('custom.icons').kinds

        return {
            enabled = function()
                if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt' then
                    return false
                end
                return true
            end,
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, item)
                    item.kind = string.format('%s', icons[item.kind])
                    item.menu = ({
                        buffer = '[Buffer]',
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
                    border = _G.global.float_border_opts.border,
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                },
                documentation = {
                    border = _G.global.float_border_opts.border,
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                },
            },
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
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
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp', priority = 1000 },
                { name = 'nvim_lsp_signature_help' },
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
            view = { entries = { name = 'custom', selection_order = 'near_cursor' } },
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
        cmp.setup(opts)
    end,
}
