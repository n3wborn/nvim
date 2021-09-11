-- autocommands
local u = require('utils')

local TrimWhitespace = vim.api.nvim_exec(
    [[
    function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
    endfunction

    call TrimWhitespace()
    ]],
    true
)

local autocmds = {
    set_formatoptions = {
        { 'BufEnter', '*', 'setlocal formatoptions-=o' },
    },
    restore_cursor = {
        { 'BufRead', '*', [[call setpos(".", getpos("'\""))]] },
    },
    resize_windows_proportionally = {
        { 'VimResized', '*', [[tabdo wincmd =]] },
    },
    solidity = {
        { 'BufRead,BufNewFile', '*.sol', 'set filetype=solidity' },
    },
    twig = {
        { 'BufRead,BufNewFile', '*.twig', 'set filetype=html.twig' },
    },
    trim_white_space = {
        { 'BufWritePre', '*', 'call TrimWhitespace()' },
    },
    git_commit = {
        { 'BufNewFile, BufRead', 'COMMIT_EDITMSG', 'set spell nonumber wrap linebreak' },
        { 'FileType', 'gitcommit', 'let b:EditorConfig_disable = 1' },
    },
}

u.nvim_create_augroups(autocmds)
