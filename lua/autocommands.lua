-- autocommands
local cmd  = vim.api.nvim_command
local exec = vim.api.nvim_exec

local TrimWhitespace = exec(
[[
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

call TrimWhitespace()
]],
true)
-- delete trailing spaces
cmd [[ autocmd BufWritePre * :call TrimWhitespace() ]]
-- check all git commit messages
cmd [[ au BufNewFile,BufRead COMMIT_EDITMSG set spell nonumber nolist wrap linebreak ]]
-- show doc at CursorHold
-- cmd[[ autocmd CursorHold  <buffer> lua vim.lsp.buf.hover() ]]
-- format on save
-- cmd[[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]]
-- disable editorconfig when I commit
cmd [[ au FileType gitcommit let b:EditorConfig_disable = 1 ]]

