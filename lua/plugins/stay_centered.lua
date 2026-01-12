return {
    'arnamak/stay-centered.nvim',
    event = 'VeryLazy',
    config = function()
        require('stay-centered').setup({
            -- skip_filetypes = { 'lua', 'typescript' }
        })
    end,
}
