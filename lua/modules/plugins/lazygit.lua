local lazygit_ok, lazygit = pcall(require, 'lazygit')

if lazygit_ok then
    vim.api.nvim_create_autocmd('BufEnter', {
        desc = 'makes sure any opened buffer inside a git repo will be tracked by lazygit',
        command = [[lua require('lazygit.utils').project_root_dir()]],
        group = vim.api.nvim_create_augroup('Lazygit', { clear = false }),
    })
end
