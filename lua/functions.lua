--- Functions

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

