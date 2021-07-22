-- https://github.com/mhartington/formatter.nvim
local function luaformat()
    return {
        exe   = 'lua-format',
        args  = { '-c', 'luaformat.rc' },
        stdin = true,
    }
end

local function luastyle()
    return {
        exe   = 'stylua',
        args  = { '--search-parent-directories' },
        stdin = true,
    }
end

local function prettier()
    return {
        exe   = 'prettier',
        args  = { '--stdin-filepath', vim.api.nvim_buf_get_name(0), '--single-quote' },
        stdin = true,
    }
end

local function rustfmt()
    return {
        exe   = 'rustfmt',
        args  = { '--emit=stdout' },
        stdin = true,
    }
end

require('formatter').setup({
    logging = false,
    filetype = {
        javascript = { prettier() },
        rust = { rustfmt() },
        lua  = { luastyle() },
    },
})
