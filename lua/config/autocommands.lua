local aug = vim.api.nvim_create_augroup('my.config', { clear = true })

vim.api.nvim_create_autocmd('VimResized', {
    group = aug,
    callback = function()
        vim.cmd.wincmd('=')
    end,
    desc = 'Keep splits equally sized',
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
    group = aug,
    callback = vim.schedule_wrap(function()
        vim.cmd.nohlsearch()
    end),
    desc = 'Remove search highlight',
})

vim.api.nvim_create_autocmd('FileType', {
    group = aug,
    pattern = {
        'gitsigns-blame',
        'git',
        'checkhealth',
        'help',
        'lspinfo',
        'man',
        'Navbuddy',
        'notify',
        'PlenaryTestPopup',
        'qf',
        'spectre_panel',
        'startuptime',
        'quickfix',
        'lazy',
    },
    callback = function(event)
        local bufnr = event.buf
        vim.bo[bufnr].buflisted = false

        vim.keymap.set('n', 'q', '<cmd>close<CR>', {
            buf = bufnr,
            silent = true,
            desc = 'Close window',
        })
    end,
    desc = 'Configure special buffers',
})

vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
    group = aug,
    callback = function()
        vim.opt_local.cursorline = true
    end,
    desc = 'Enable cursorline in active window',
})

vim.api.nvim_create_autocmd('WinLeave', {
    group = aug,
    callback = function()
        if vim.bo.buftype ~= 'quickfix' then
            vim.opt_local.cursorline = false
        end
    end,
    desc = 'Disable cursorline when leaving window',
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = aug,
    callback = function()
        vim.hl.hl_op()
    end,
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        print(vim.fn.arglistid())

        if vim.fn.argc() > 0 then
            return
        end

        vim.schedule(function()
            require('persistence').load()
        end)
    end,
    desc = 'Restore last current dir (or last) session',
})

-- taken from https://github.com/BurntSushi/dotfiles/blob/master/.config/nvim/lua/autos.lua
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'BufWinEnter', 'CursorHold', 'CursorHoldI' }, {
    callback = function()
        if vim.fn.mode() ~= 'c' then
            vim.cmd.checktime()
        end
    end,
    desc = 'Force reload of files that change on disk outside of vim (see also autoread in options.lua)',
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
    callback = function()
        vim.cmd.echohl('WarningMsg')
        vim.cmd.echo([["File changed on disk. Buffer reloaded."]])
        vim.cmd.echohl('None')
    end,
    desc = 'Emits a warning if the file changed.',
})
