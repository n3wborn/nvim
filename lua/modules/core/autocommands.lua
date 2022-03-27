local autocmd = vim.api.nvim_create_autocmd

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
})

autocmd({ 'BufNewFile', 'BufRead' }, {
    desc = 'Fix solidity filetype',
    pattern = '*.sol',
    command = 'set filetype=solidity',
})

autocmd({ 'BufNewFile', 'BufRead' }, {
    desc = 'Fix twig filetype',
    pattern = '*.twig',
    command = 'set filetype=html.twig',
})

autocmd({ 'BufNewFile', 'BufRead' }, {
    desc = 'Git commit messages settings',
    pattern = 'COMMIT_EDITMSG',
    command = 'set spell nonumber wrap linebreak',
})

autocmd({ 'FileType' }, {
    desc = 'Git messages settings',
    pattern = 'gitcommit',
    command = 'let b:EditorConfig_disable=1',
})

autocmd('CursorHold', {
    desc = 'Show current line diagnostics',
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false, scope = 'cursor' })
    end,
})

autocmd('BufEnter', {
    desc = 'makes sure any opened buffer inside a git repo will be tracked by lazygit',
    command = [[lua require('lazygit.utils').project_root_dir()]],
})

autocmd('BufEnter', {
    desc = 'Quit nvim if nvim-tree is the last buffer',
    command = 'if winnr("$") == 1 && bufname() == "NvimTree_" . tabpagenr() | quit | endif',
})
