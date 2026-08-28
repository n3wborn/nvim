local uv = vim.uv or vim.loop
local e = vim.fn.fnameescape

local M = {}

M.dir = vim.fn.stdpath('state') .. '/sessions/'
M.need = 0 -- minimum number of file buffers required to save (0 = always save)
M.branch = true -- include the git branch name in the session key

local function git_branch()
    if uv.fs_stat('.git') then
        local ret = vim.fn.systemlist('git branch --show-current')[1]
        return vim.v.shell_error == 0 and ret or nil
    end
end

---@param opts? { branch?: boolean }
function M.current(opts)
    opts = opts or {}
    local name = vim.fn.getcwd():gsub('[\\/:]+', '%%')
    if M.branch and opts.branch ~= false then
        local branch = git_branch()
        if branch and branch ~= 'main' and branch ~= 'master' then
            name = name .. '%%' .. branch:gsub('[\\/:]+', '%%')
        end
    end
    return M.dir .. name .. '.vim'
end

function M.save()
    vim.fn.mkdir(M.dir, 'p')
    vim.cmd('mksession! ' .. e(M.current()))
end

---@return string[]
function M.list()
    local sessions = vim.fn.glob(M.dir .. '*.vim', true, true)
    table.sort(sessions, function(a, b)
        return uv.fs_stat(a).mtime.sec > uv.fs_stat(b).mtime.sec
    end)
    return sessions
end

function M.last()
    return M.list()[1]
end

---@param opts? { last?: boolean }
function M.load(opts)
    opts = opts or {}
    local file
    if opts.last then
        file = M.last()
    else
        file = M.current()
        if vim.fn.filereadable(file) == 0 then
            file = M.current({ branch = false })
        end
    end
    if file and vim.fn.filereadable(file) ~= 0 then
        vim.cmd('silent! source ' .. e(file))
    end
end

function M.select()
    ---@type { session: string, dir: string, branch?: string }[]
    local items = {}
    local have = {} ---@type table<string, boolean>
    for _, session in ipairs(M.list()) do
        if uv.fs_stat(session) then
            local file = session:sub(#M.dir + 1, -5)
            local dir, branch = unpack(vim.split(file, '%%', { plain = true }))
            dir = dir:gsub('%%', '/')
            if jit.os:find('Windows') then
                dir = dir:gsub('^(%w)/', '%1:/')
            end
            if not have[dir] then
                have[dir] = true
                items[#items + 1] = { session = session, dir = dir, branch = branch }
            end
        end
    end
    vim.ui.select(items, {
        prompt = 'Select a session: ',
        format_item = function(item)
            return vim.fn.fnamemodify(item.dir, ':p:~')
        end,
    }, function(item)
        if item then
            vim.fn.chdir(item.dir)
            M.load()
        end
    end)
end

local active = false

function M.stop()
    active = false
    pcall(vim.api.nvim_del_augroup_by_name, 'my.sessions')
end

function M.start()
    if active then
        return
    end
    active = true
    vim.fn.mkdir(M.dir, 'p')
    vim.api.nvim_create_autocmd('VimLeavePre', {
        group = vim.api.nvim_create_augroup('my.sessions', { clear = true }),
        callback = function()
            if M.need > 0 then
                local bufs = vim.tbl_filter(function(b)
                    if
                        vim.bo[b].buftype ~= ''
                        or vim.tbl_contains({ 'gitcommit', 'gitrebase', 'jj' }, vim.bo[b].filetype)
                    then
                        return false
                    end
                    return vim.api.nvim_buf_get_name(b) ~= ''
                end, vim.api.nvim_list_bufs())
                if #bufs < M.need then
                    return
                end
            end
            M.save()
        end,
        desc = 'Save session for current directory on exit',
    })
end

return M
