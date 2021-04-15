-- autocommands
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')

local u = require('utils')

cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode

-- delete trailing spaces
cmd 'autocmd BufWritePre * :call TrimWhitespace()'

-- check all git commit messages
cmd 'au BufNewFile,BufRead COMMIT_EDITMSG set spell nonumber nolist wrap linebreak'
