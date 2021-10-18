-- autocommands
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
    true
)

-- don't auto commenting new lines
exec([[au BufEnter * set fo-=c fo-=r fo-=o]], false)

-- disable IndentLine for markdown files (avoid concealing)
exec([[au FileType markdown let g:indentLine_enabled=0]], false)

-- keep windows equally resized
exec([[au VimResized * tabdo wincmd =]], false)

-- filetype
exec([[au BufRead,BufNewFile *.sol set filetype=solidity]], false)
exec([[au BufRead,BufNewFile *.twig set filetype=html.twig]], false)

-- git commit
exec([[au BufNewFile,BufRead COMMIT_EDITMSG set spell nonumber wrap linebreak]], false)
exec([[au filetype gitcommit let b:EditorConfig_disable=1]], false)

-- trim_white_space
exec([[au BufWritePre * call TrimWhitespace()]], false)
