local aug = vim.api.nvim_create_augroup('my.config', { clear = true })

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'TermClose', 'TermLeave' }, {
    group = aug,
    callback = function(ev)
        if vim.fn.getcmdwintype() ~= '' then
            return
        end

        if ev.event == 'FocusGained' or ev.event == 'TermClose' or ev.event == 'TermLeave' then
            vim.cmd('checktime')
            return
        end

        local bo = vim.bo[ev.buf]
        if bo.buftype == '' and not bo.modified and vim.api.nvim_buf_get_name(ev.buf) ~= '' then
            vim.cmd('checktime ' .. ev.buf)
        end
    end,
    desc = 'Auto reload files changed on disk',
})

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

vim.api.nvim_create_autocmd('User', {
    pattern = 'PersistenceSavePre',
    callback = function()
        local ignored_filetypes = {
            'NeogitStatus',
            'NeogitCommitMessage',
            'snacks_dashboard',
        }

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local ft = vim.bo[buf].filetype
            local bt = vim.bo[buf].buftype

            if bt ~= '' or vim.tbl_contains(ignored_filetypes, ft) then
                vim.api.nvim_buf_delete(buf, {})
            end
        end
    end,
    desc = 'Only keep useful buffers into sessions',
})
