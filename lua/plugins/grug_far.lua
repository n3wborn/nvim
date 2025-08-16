    ---@type LazyPluginSpec
return {
    'MagicDuck/grug-far.nvim',
    keys = {
        {
            '<leader>rs',
            function()
                require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })
            end,
            mode = { 'n', 'x' },
            desc = ' Search and Replace',
        },
    },

    config = function()
        require('grug-far').setup()
    end,
}
