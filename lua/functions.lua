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


local function check_back_space()
	local col = fn.col('.') - 1
	return not not (col == 0 or fn.getline('.'):sub(col, col):match('%s'))
end

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



--- https://github.com/mjlbach/nix-dotfiles/blob/master/nixpkgs/configs/neovim/init.lua
--
--
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
--
-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
  --   return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
  -- me-
  --   return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end
