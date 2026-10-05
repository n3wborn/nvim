local add = require('vim-pack').add

add({
    { src = 'nvim-lua/plenary.nvim', setup = false },
    { src = 'dlyongemallo/diffview-plus.nvim', setup = false },
    {
        src = 'NeogitOrg/neogit',
        opts = {
            graph_style = 'kitty',
            -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
            integrations = {
                codediff = false,
                telescope = false,
                fzf_lua = true,
                mini_pick = false,
                diffview = true,
                snacks = true,
            },
            diff_viewer = 'diffview',
            sections = {
                recent = {
                    folded = false,
                },
            },
            signs = {
                -- { CLOSED, OPENED }
                hunk = { '', '' },
                item = { '', '' },
                section = { '', '' },
            },
        },
        on_setup = function()
            vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = 'Open Neogit' })
        end,
    },
})
