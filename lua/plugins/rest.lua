-- https://github.com/rest-nvim/rest.nvim
return {
    'vhyrro/luarocks.nvim',
    config = function()
        require('luarocks').setup({})
    end,
}, {
    'rest-nvim/rest.nvim',
    ft = 'http',
    dependencies = { 'luarocks.nvim' },
    config = function()
        require('rest-nvim').setup()
    end,
}
