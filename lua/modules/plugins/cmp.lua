-- https://github.com/hrsh7th/nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

require('luasnip.loaders.from_vscode').lazy_load()
vim.api.nvim_command('hi LuasnipChoiceNodePassive cterm=italic')

vim.opt.completeopt = 'menu,menuone,noselect'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(entry, item)
            local menu_map = {
                buffer = '[Buf]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[API]',
                path = '[Path]',
                luasnip = '[Snip]',
                rg = '[RG]',
            }

            item.menu = menu_map[entry.source.name] or string.format('[%s]', entry.source.name)
            item.kind = vim.lsp.protocol.CompletionItemKind[item.kind]

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
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4)),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete()),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-n>'] = {
            c = function(fallback)
                local cmp = require('cmp')
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
        },
        ['<C-p>'] = {
            c = function(fallback)
                local cmp = require('cmp')
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end,
        },
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 10 },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
    }, {
        { name = 'nvim_lua' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'rg' },
    }),
})

-- https://github.com/windwp/nvim-autopairs
require('nvim-autopairs').setup()
