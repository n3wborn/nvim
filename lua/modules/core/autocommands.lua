local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_augroup('Git', { clear = false })
vim.api.nvim_create_augroup('UI', { clear = false })

autocmd('BufEnter', {
    desc = 'Do not auto comment on new line',
    command = 'set fo-=c fo-=r fo-=o',
})

autocmd({ 'FileType markdown' }, {
    desc = 'Disable IndentLine for markdown files',
    command = 'let g:indentLine_enabled=0',
})

autocmd('VimResized', {
    desc = 'Keep windows equally resized',
    command = 'tabdo wincmd =',
    group = 'UI',
})

autocmd({ 'BufNewFile', 'BufRead' }, {
    desc = 'Git commit messages settings',
    pattern = 'COMMIT_EDITMSG',
    command = 'set spell nonumber wrap linebreak',
    group = 'Git',
})

autocmd({ 'FileType' }, {
    desc = 'Git messages settings',
    pattern = 'gitcommit',
    command = 'let b:EditorConfig_disable=1',
    group = 'Git',
})

autocmd({ 'BufReadPre' }, {
    desc = 'return to last position known inside a buffer',
    pattern = '*',
    callback = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = '<buffer>',
            once = true,
            callback = function()
                vim.cmd(
                    [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
                )
            end,
        })
    end,
})

autocmd({ 'InsertLeave', 'WinEnter' }, {
    desc = 'show cursor line only in active window',
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, 'auto-cursorline')
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, 'auto-cursorline')
        end
    end,
})

autocmd({ 'InsertEnter', 'WinLeave' }, {
    desc = 'show cursor line only in active window',
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, 'auto-cursorline', cl)
            vim.wo.cursorline = false
        end
    end,
})

autocmd({ 'BufWritePre' }, {
    desc = 'create directories when needed, when saving a file',
    group = vim.api.nvim_create_augroup('auto_create_dir', { clear = true }),
    callback = function(event)
        local file = vim.loop.fs_realpath(event.match) or event.match

        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
        local backup = vim.fn.fnamemodify(file, ':p:~:h')
        backup = backup:gsub('[/\\]', '%%')
        vim.go.backupext = backup
    end,
})

autocmd({ 'FileType' }, {
    desc = 'Fix conceallevel for json & help files',
    pattern = { 'json', 'jsonc' },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
})

autocmd({ 'BufWritePre' }, {
    desc = 'trim buffer whitespaces',
    pattern = '*',
    command = 'TrimTrailingWhitespace',
})

autocmd({ 'BufWinLeave' }, {
    desc = 'Remember current folds',
    pattern = '*.*',
    command = 'mkview',
    group = 'UI',
})

autocmd({ 'BufWinEnter' }, {
    desc = 'Reload folds as they were',
    pattern = '*.*',
    command = 'loadview',
    group = 'UI',
})

autocmd({ 'FileType' }, {
    desc = 'close windows using "q"',
    pattern = {
        'qf',
        'help',
        'man',
        'notify',
        'lspinfo',
        'startuptime',
        'tsplayground',
        'PlenaryTestPopup',
    },
    callback = function()
        vim.cmd([[
    nnoremap <silent> <buffer> q <cmd>close<CR>
    set nobuflisted
    ]])
    end,
})
