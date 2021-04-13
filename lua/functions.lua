--- Functions

local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()

local TrimWhitespace = vim.api.nvim_exec(
[[
function! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfunction

call TrimWhitespace()
]],
true)

local ShowDocumentation = vim.api.nvim_exec(
[[
function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >=0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction
]]
, false)


-- hl_yank: highlight the area that was just yanked
-- restore_curpos: restore the last position of the cursor in a file. Taken from Vim's defaults.vim
vim.api.nvim_exec([[
augroup hl_yank
  autocmd!
  autocmd TextYankPost * lua require('vim.highlight').on_yank()
augroup END

augroup restore_curpos
  autocmd!
  autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
augroup END
]], false)


