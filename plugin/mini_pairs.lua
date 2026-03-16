vim.api.nvim_create_autocmd('InsertEnter', {
    once = true,
    callback = function()
        vim.pack.add({
            {
                src = 'https://github.com/nvim-mini/mini.pairs',
                version = 'main',
            },
        })

        require('mini.pairs').setup()
    end,
})
