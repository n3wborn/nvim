-- autocommands
local cmd = vim.api.nvim_command

-- delete trailing spaces
cmd('autocmd BufWritePre * :call TrimWhitespace()')
-- check all git commit messages
cmd('au BufNewFile,BufRead COMMIT_EDITMSG set spell nonumber nolist wrap linebreak')
-- show doc at CursorHold
--cmd('autocmd CursorHold  <buffer> lua vim.lsp.buf.hover()')
