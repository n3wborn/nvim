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

