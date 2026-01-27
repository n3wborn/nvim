return {
    src = 'https://github.com/nvim-lua/plenary.nvim',
    data = {
        setup = function()
            local ok, val = pcall(require, 'plenary')
            if not ok then
                vim.notify('plenary not loaded')
            end
        end,
    },
}
