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


function _G.statusline()
    local filepath = '%f'
    local align_section = '%='
    local percentage_through_file = '%p%%'
    return string.format(
        '%s%s%s',
        filepath,
        align_section,
        percentage_through_file
    )
end


function _G.check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')) and true
end
