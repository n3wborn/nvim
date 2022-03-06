-- autocommands
vim.api.nvim_create_autocmd('BufEnter', {
    desc = 'Do not auto comment on new line',
    command = 'set fo-=c fo-=r fo-=o',
})

vim.api.nvim_create_autocmd({ 'FileType markdown' }, {
    desc = 'Disable IndentLine for markdown files',
    command = 'let g:indentLine_enabled=0',
})

-- keep windows equally resized
vim.api.nvim_create_autocmd('VimResized', {
    desc = 'Keep windows equally resized',
    command = 'tabdo wincmd =',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    desc = 'Fix solidity filetype',
    pattern = '*.sol',
    command = 'set filetype=solidity',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    desc = 'Fix twig filetype',
    pattern = '*.twig',
    command = 'set filetype=html.twig',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    desc = 'Git commit messages settings',
    pattern = 'COMMIT_EDITMSG',
    command = 'set spell nonumber wrap linebreak',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    desc = 'Git messages settings',
    pattern = 'gitcommit',
    command = 'let b:EditorConfig_disable=1',
})

vim.api.nvim_create_autocmd('CursorHold', {
    desc = 'Show current line diagnostics',
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false, scope = 'cursor' })
    end,
})
