local get_map_options = function(custom_options)
    local options = { noremap = true, silent = true }
    if custom_options then
        options = vim.tbl_extend('force', options, custom_options)
    end
    return options
end

local M = {}

M.map = function(mode, target, source, opts)
    vim.keymap.set(mode, target, source, get_map_options(opts))
end

for _, mode in ipairs({ 'n', 'o', 'i', 'x', 't' }) do
    M[mode .. 'map'] = function(...)
        M.map(mode, ...)
    end
end

M.buf_map = function(bufnr, mode, target, source, opts)
    opts = opts or {}
    opts.buffer = bufnr

    M.map(mode, target, source, get_map_options(opts))
end

M.buf_command = function(bufnr, name, fn, opts)
    vim.api.nvim_buf_create_user_command(bufnr, name, fn, opts or {})
end

M.yank_file_path = function()
    local file_path = vim.api.nvim_buf_get_name(0)
    vim.fn.setreg('+', file_path)
    vim.api.nvim_echo({ { 'File path copied to clipboard: ' .. file_path } }, true, {})
end

return M
