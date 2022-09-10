-- https://github.com/kylechui/nvim-surround
local surround_ok, surround = pcall(require, 'nvim-surround')

if not surround_ok then
    print('Something went wrong with', surround)
    return
else
    surround.setup({
        keymaps = {
            insert = 'ys',
            visual = 'S',
            delete = 'ds',
            change = 'cs',
        },
    })
end
