return {
    src = 'https://github.com/folke/lazydev.nvim',
    data = {
        setup = function()
            ---@type lazydev.Config
            local opts = {
                library = {
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                },
            }

            vim.schedule(function()
                require('lazydev').setup(opts)
            end)
        end,
    },
}
