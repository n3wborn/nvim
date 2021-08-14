-- https://github.com/mhartington/formatter.nvim
local function luaformat()
    return {
        exe = 'lua-format',
        args = { '-c', 'luaformat.rc' },
        stdin = true,
    }
end

local function luastyle()
    return {
        exe = 'stylua',
        args = { '--search-parent-directories', '-' },
        stdin = true,
    }
end

local function prettier()
    return {
        exe = 'prettier',
        args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
        stdin = true,
    }
end

local function eslint_d()
    return {
        exe = 'eslint_d',
        args = { '--fix-to-stdout', '--stdin', '--stdin-filename', vim.api.nvim_buf_get_name(0) },
        stdin = true,
    }
end

local function rustfmt()
    return {
        exe = 'rustfmt',
        args = { '--emit=stdout' },
        stdin = true,
    }
end

require('formatter').setup({
    logging = false,
    filetype = {
        javascript = { eslint_d },
        rust = { rustfmt },
        lua = { luastyle },
    },
})
