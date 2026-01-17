return {
    src = 'https://github.com/NeogitOrg/neogit',
    data = {
        setup = function()
            local opts = {
                graph_style = 'kitty',
                integrations = {
                    telescope = false,
                    fzf_lua = false,
                    mini_pick = false,
                    diffview = true,
                    snacks = true,
                },
            }

            require('neogit').setup(opts)

            vim.keymap.set('n', '<space>G', function()
                require('neogit').open()
            end)
        end,
    },
}
