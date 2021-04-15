-- autocommands
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')

-- delete trailing spaces
cmd 'autocmd BufWritePre * :call TrimWhitespace()'
-- check all git commit messages
cmd 'au BufNewFile,BufRead COMMIT_EDITMSG set spell nonumber nolist wrap linebreak'
