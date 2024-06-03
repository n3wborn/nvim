return {
    {
        'Rizwanelansyah/simplyfile.nvim',
        config = function()
            require('simplyfile').setup({
                border = {
                    left = 'rounded',
                    main = 'double',
                    right = 'rounded',
                },
                default_keymaps = true,
            })
        end,
    },
}
