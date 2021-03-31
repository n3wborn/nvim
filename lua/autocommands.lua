-- autocommands
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')

local u = require('utils')

cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode

-- delete trailing spaces
cmd 'autocmd BufWritePre * :call TrimWhitespace()'

-- check all git commit messages
cmd 'au BufNewFile,BufRead COMMIT_EDITMSG set spell nonumber nolist wrap linebreak'

-- filetype tab settings
cmd 'au FileType sass,ruby,json,haml,eruby,yaml,coffee,cucumber,stylus,css,xml,html,django set ai ts=2 sw=2 sts=2 et'
cmd 'au FileType php,javascript,python,doctest set ai ts=4 sw=4 sts=4 et'

