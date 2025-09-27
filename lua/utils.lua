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

-- taken from https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/folding-plugins.lua
M.foldTextFormatter = function(virtText, lnum, endLnum, width, truncate)
    local foldIcon = ''
    local hlgroup = 'NonText'
    local newVirtText = {}
    local suffix = '  ' .. foldIcon .. '  ' .. tostring(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, hlgroup })
    return newVirtText
end

---@param msg string
M.notif = function(msg)
    vim.schedule(function()
        vim.notify(msg)
    end)
end

M.enable_copilot = function()
    return vim.ui.select({ 'Yes', 'No' }, {
        prompt = 'Enable Copilot: ',
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice == 'Yes' then
            vim.g.copilot_enabled = true
        else
            vim.g.copilot_enabled = false
        end
    end)
end

M.enable_cursor = function()
    return vim.ui.select({ 'Yes', 'No' }, {
        prompt = 'Enable Cursor: ',
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice == 'Yes' then
            vim.g.cursor_enabled = true
        else
            vim.g.cursor_enabled = false
        end
    end)
end

M.command('GitsignsDiffToggle', function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local diff_win = nil

    for _, win in ipairs(wins) do
        local bufnr = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name:match('^gitsigns://') then
            diff_win = win
            break
        end
    end

    if diff_win then
        pcall(vim.api.nvim_win_close, diff_win, false)

        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local bufnr = vim.api.nvim_win_get_buf(win)
            local name = vim.api.nvim_buf_get_name(bufnr)
            if not name:match('^gitsigns://') then
                vim.api.nvim_set_current_win(win)
                vim.cmd('diffoff')
                vim.cmd('redraw!')
                break
            end
        end
    else
        vim.cmd('Gitsigns diffthis')
    end
end, { desc = 'Toggle Gitsigns diff: close or open diffthis' })

return M
