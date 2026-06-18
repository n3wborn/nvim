local api = vim.api

local M = {}

local default_map_opts = {
    silent = true,
}

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.map(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', default_map_opts, opts or {}))
end

---@param bufnr integer
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function M.buf_map(bufnr, mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, unpack(opts or {}) })
end

---@param name string name given to the command
---@param fn function to be execute when calling the command
---@param opts table options to set for the user command
function M.command(name, fn, opts)
    api.nvim_create_user_command(name, fn, opts or {})
end

function M.buf_command(bufnr, name, fn, opts)
    api.nvim_buf_create_user_command(bufnr, name, fn, opts or {})
end

function M.t(keys)
    return vim.keycode(keys)
end

function M.input(keys)
    vim.api.nvim_input(M.t(keys))
end

function M.warn(msg)
    vim.notify(msg, vim.log.levels.WARN)
end

function M.info(msg)
    vim.notify(msg, vim.log.levels.INFO)
end

function M.print(...)
    vim.print(...)
end

function M.cwd()
    return vim.uv.cwd()
end

function M.is_file(path)
    local stat = vim.uv.fs_stat(path)

    return stat ~= nil and stat.type == 'file'
end

---@param markers? string[]
---@param file string
---@return string|nil
function M.root(markers, file)
    local found = vim.fs.find(markers or { '.git' }, { upward = true, path = vim.fs.dirname(file) })[1]

    return found and vim.fs.dirname(found) or nil
end

function M.yank_file_path()
    local path = api.nvim_buf_get_name(0)

    vim.fn.setreg('+', path)

    vim.notify(('Copied: %s'):format(path), vim.log.levels.INFO)
end

M.table = {}

function M.table.some(tbl, predicate)
    return vim.iter(pairs(tbl)):any(function(k, v)
        return predicate(v, k)
    end)
end

function M.table.find(tbl, predicate)
    for k, v in pairs(tbl) do
        if predicate(v, k) then
            return v, k
        end
    end
end

function M.timer()
    local start = vim.uv.hrtime()

    return function()
        return (vim.uv.hrtime() - start) / 1e6
    end
end

function M.undotree()
    local close = require('undotree').open({ title = 'Undotree', command = 'topleft 30vnew' })

    if not close then
        vim.bo.filetype = 'undotree'
    end
end

return M
