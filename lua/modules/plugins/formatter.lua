-- https://github.com/mhartington/formatter.nvim
local function luaformat()
    return {
        exe = 'lua-format',
        args = {
            '-c',
            'luaformat.rc',
        },
        stdin = true,
    }
end

local function luastyle()
    return {
        exe = 'stylua',
        args = {
            '--search-parent-directories',
            '-',
        },
        stdin = true,
    }
end

local function prettier()
    return {
        exe = 'prettier',
        args = {
            '--stdin-filepath',
            vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
        },
        stdin = true,
    }
end

local function prettier_d()
    return {
        exe = 'prettierd',
        args = { vim.api.nvim_buf_get_name(0) },
        stdin = true,
    }
end

local function eslint_d()
    return {
        exe = 'eslint_d',
        args = {
            '--fix-to-stdout',
            '--stdin',
            '--stdin-filename',
            vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
        },
        stdin = true,
    }
end

local function eslint()
    return {
        exe = 'eslint',
        args = {
            '--fix',
            '--stdin',
            '--stdin-filename',
            vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
        },
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

local function shfmt()
    return {
        exe = 'shfmt',
        stdin = true,
    }
end

local function vue()
    return {
        exe = 'prettier',
        args = {
            '--stdin-filepath',
            vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
            '--single-quote',
            '--parser',
            'vue',
        },
        stdin = true,
    }
end

require('formatter').setup({
    logging = false,
    filetype = {
        javascript = { prettier },
        scss = { prettier },
        rust = { rustfmt },
        lua = { luastyle },
        vue = { vue },
        sh = { shfmt },
    },
})
