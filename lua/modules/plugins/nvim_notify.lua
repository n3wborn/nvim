-- https://github.com/rcarriga/nvim-notify
local notify_ok, vim_notify = pcall(require, 'notify')

if not notify_ok then
    print('Something went wrong with nvim-notify')
    return
else
    vim.notify = vim_notify
    vim_notify.setup()
end
