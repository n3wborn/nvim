return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    enabled = true,
    ---@type Flash.Config
    keys = {
        {
            's',
            mode = { 'n' },
            function()
                require('flash').jump()
            end,
            desc = 'Flash',
        },
    },
}
