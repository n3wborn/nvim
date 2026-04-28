local api = vim.api

-- global inspect fn
_G.inspect = function(...)
    print(vim.inspect(...))
end

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

M.for_each = function(tbl, cb)
    for _, v in ipairs(tbl) do
        cb(v)
    end
end

M.buf_command = function(bufnr, name, fn, opts)
    api.nvim_buf_create_user_command(bufnr, name, fn, opts or {})
end

M.table = {
    some = function(tbl, cb)
        for k, v in pairs(tbl) do
            if cb(k, v) then
                return true
            end
        end
        return false
    end,
}

M.timer = {
    start_time = nil,
    start = function()
        M.timer.start_time = vim.loop.now()
    end,
    stop = function()
        print(vim.loop.now() - M.timer.start_time .. ' ms')
        M.timer.start_time = nil
    end,

    start_nano = function()
        M.timer.start_time = vim.loop.hrtime()
    end,
    stop_nano = function()
        print(vim.loop.hrtime() - M.timer.start_time .. ' ns')
        M.timer.start_time = nil
    end,
}

M.command = function(name, fn, opts)
    api.nvim_create_user_command(name, fn, opts or {})
end

M.t = function(str)
    return vim.keycode(str)
end

M.input = function(keys, mode)
    vim.api.nvim_feedkeys(M.t(keys), mode or 'i', true)
end

M.warn = function(msg)
    api.nvim_echo({ { msg, 'WarningMsg' } }, true, {})
end

M.is_file = function(path)
    if path == '' then
        return false
    end

    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == 'file'
end

M.get_cwd = function()
    return assert(vim.uv.cwd)
end

---@param files table
---@param file_name string
M.get_root_dir = function(files, file_name)
    vim.fs.dirname(vim.fs.find(files or { '.git' }, {
        upward = true,
        path = vim.fs.dirname(file_name),
    })[1])
end

M.yank_file_path = function()
    local file_path = vim.api.nvim_buf_get_name(0)
    vim.fn.setreg('+', file_path)
    vim.api.nvim_echo({ { 'File path copied to clipboard: ' .. file_path } }, true, {})
end

---@param msg string
M.notif = function(msg)
    vim.schedule(function()
        vim.notify(msg)
    end)
end

M.has_ts_folds = function(bufnr)
    bufnr = bufnr or 0

    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then
        return false
    end

    local lang = parser:lang()
    return vim.treesitter.query.get(lang, 'folds') ~= nil
end

M.set_folds = function(bufnr)
    if M.has_ts_folds(bufnr) then
        vim.opt_local.foldmethod = 'expr'
        vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    else
        vim.opt_local.foldmethod = 'indent'
    end
end

M.undotree = function()
    local close = require('undotree').open({
        title = 'Undotree',
        command = 'topleft 30vnew',
    })
    if not close then
        vim.bo.filetype = 'undotree'
    end
end

return M
