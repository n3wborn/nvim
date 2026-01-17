return {
    src = 'https://github.com/HiPhish/rainbow-delimiters.nvim',
    data = {
        setup = function()
            require('rainbow-delimiters.setup').setup()
        end,
    },
}
