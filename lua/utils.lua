local uv = vim.loop
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

-- (see :h command-preview or https://github.com/neovim/neovim/commit/7380ebfc17723662f6fe1e38372f54b3d67fe082)
local function trim_space(opts, preview_ns, preview_buf)
    local line1 = opts.line1
    local line2 = opts.line2
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, line1 - 1, line2, true)
    local new_lines = {}
    local preview_buf_line = 0
    for i, line in ipairs(lines) do
        local startidx, endidx = string.find(line, '%s+$')
        if startidx ~= nil then
            -- Highlight the match if in command preview mode
            if preview_ns ~= nil then
                api.nvim_buf_add_highlight(buf, preview_ns, 'Substitute', line1 + i - 2, startidx - 1, endidx)
                -- Add lines and highlight to the preview buffer
                -- if inccommand=split
                if preview_buf ~= nil then
                    local prefix = string.format('|%d| ', line1 + i - 1)
                    api.nvim_buf_set_lines(preview_buf, preview_buf_line, preview_buf_line, true, { prefix .. line })
                    api.nvim_buf_add_highlight(
                        preview_buf,
                        preview_ns,
                        'Substitute',
                        preview_buf_line,
                        #prefix + startidx - 1,
                        #prefix + endidx
                    )
                    preview_buf_line = preview_buf_line + 1
                end
            end
        end
        if not preview_ns then
            new_lines[#new_lines + 1] = string.gsub(line, '%s+$', '')
        end
    end
    -- Don't make any changes to the buffer if previewing
    if not preview_ns then
        api.nvim_buf_set_lines(buf, line1 - 1, line2, true, new_lines)
    end
    -- When called as a preview callback, return the value of the
    -- preview type
    if preview_ns ~= nil then
        return 2
    end
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
        M.timer.start_time = uv.now()
    end,
    stop = function()
        print(uv.now() - M.timer.start_time .. ' ms')
        M.timer.start_time = nil
    end,

    start_nano = function()
        M.timer.start_time = uv.hrtime()
    end,
    stop_nano = function()
        print(uv.hrtime() - M.timer.start_time .. ' ns')
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
    return uv.cwd
end

M.trim_trailing_whitespace =
    M.command('TrimTrailingWhitespace', trim_space, { nargs = '?', range = '%', addr = 'lines', preview = trim_space })

---@param level number|nil
---@param msg string
---@param title string
M.notif = function(title, msg, level)
    vim.notify(msg, level, {
        title = title,
    })
end

return M
