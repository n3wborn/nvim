-- autocommands

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
    toggle_search_highlighting = {
        { 'InsertEnter', '*', [[:nohlsearch | redraw]] },
    },
    wins = {
        -- Highlight current line only on focused window
        { 'WinEnter,BufEnter,InsertLeave', '*', [[if ! &cursorline && ! &pvw | setlocal cursorline | endif]] },
        { 'WinLeave,BufLeave,InsertEnter', '*', [[if &cursorline && ! &pvw | setlocal nocursorline | endif]] },
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
    -- formatting_sync = {
    --     {"BufWritePre", "*", "lua vim.lsp.buf.formatting_sync()"};
    -- };
    git_commit = {
        { 'BufNewFile, BufRead', 'COMMIT_EDITMSG', 'set spell nonumber wrap linebreak' },
        { 'FileType', 'gitcommit', 'let b:EditorConfig_disable = 1' },
    },
    -- hover = {
    --     {"CursorHold", "*", "lua vim.lsp.buf.hover()"};
    -- };
    -- formatter = {
    --     { 'BufWritePost', '*.js,*.rs,*.lua', 'FormatWrite' },
    -- },
}

require('utils').nvim_create_augroups(autocmds)
