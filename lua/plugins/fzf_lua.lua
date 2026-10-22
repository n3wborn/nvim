--- Run git from the repository (project or submodule) that owns `file`.
--- Starts from the parent dir so a submodule entry targets the superproject.
local function git_owner_exec(root, file, args)
    local abs = file:sub(1, 1) == '/' and file or vim.fs.joinpath(root, file)
    local dir = vim.fs.dirname(abs)
    while not vim.uv.fs_stat(dir) do
        dir = vim.fs.dirname(dir)
    end
    local cmd = vim.list_extend({ 'git', '-C', dir }, args)
    table.insert(cmd, abs)
    return vim.system(cmd, { text = true }):wait()
end

--- Commit to diff the files of `dir` against: inside a submodule, the merge base of HEAD and
--- the commit recorded by the superproject's HEAD (so its new commits are part of the diff,
--- but not the ones of a diverged recorded commit), HEAD otherwise.
local function git_base(dir)
    local function git(cwd, ...)
        local r = vim.system({ 'git', '-C', cwd, ... }, { text = true }):wait()
        return r.code == 0 and vim.trim(r.stdout) or ''
    end
    local super = git(dir, 'rev-parse', '--show-superproject-working-tree')
    if super == '' then
        return 'HEAD'
    end
    local top = git(dir, 'rev-parse', '--show-toplevel')
    local base = git(super, 'rev-parse', '-q', '--verify', 'HEAD:' .. top:sub(#super + 2))
    base = base ~= '' and git(dir, 'merge-base', base, 'HEAD') or ''
    return base ~= '' and base or 'HEAD'
end

--- Same as git_owner_exec, as a shell command for fzf previews ({file} is substituted by fzf-lua).
--- `$b` is the commit given by git_base.
local function git_owner_preview(root, args)
    return (
        [[cd %s && sh -c 'f=$(realpath -m -- "$1"); d=$(dirname -- "$f"); ]]
        .. [[while [ ! -d "$d" ]; do d=$(dirname -- "$d"); done; b=HEAD; ]]
        .. [[sp=$(git -C "$d" rev-parse --show-superproject-working-tree); if [ -n "$sp" ]; then ]]
        .. [[t=$(git -C "$d" rev-parse --show-toplevel); ]]
        .. [[b=$(git -C "$sp" rev-parse -q --verify "HEAD:${t#"$sp"/}") ]]
        .. [[&& b=$(git -C "$d" merge-base "$b" HEAD) || b=HEAD; fi; ]]
        .. [[git -C "$d" %s "$f"' _ {file}]]
    ):format(vim.fn.shellescape(root), args)
end

--- git status including the files changed inside (nested) submodules.
local function git_status_recursive()
    local fzf_lua = require('fzf-lua')
    local res = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true }):wait()
    if res.code ~= 0 then
        return fzf_lua.utils.warn('not a git repository')
    end
    local root = vim.trim(res.stdout)
    local status = '-c color.status=false --no-optional-locks status --porcelain=v1 -u --no-renames'

    -- submodule files are displayed as `[name] path/in/submodule`,
    -- the path from the root is used instead when a name is not unique
    local subs = vim.system({
        'git',
        'submodule',
        'foreach',
        '--recursive',
        '--quiet',
        'printf "%s\\t%s\\t%s\\n" "$name" "$displaypath" "$(git -C "$toplevel" rev-parse -q --verify HEAD:"$sm_path")"',
    }, { cwd = root, text = true }):wait()
    local list, count, paths = {}, {}, {}
    for name, path, base in (subs.stdout or ''):gmatch('([^\t\n]+)\t([^\t\n]+)\t([^\n]*)') do
        list[#list + 1] = { name = name, path = path, base = base }
        count[name] = (count[name] or 0) + 1
    end
    local cmds = { ('git -C %s %s'):format(vim.fn.shellescape(root), status) }
    for _, sub in ipairs(list) do
        local label = count[sub.name] == 1 and sub.name or sub.path
        local dir = vim.fn.shellescape(vim.fs.joinpath(root, sub.path))
        paths[label] = sub.path
        -- files changed by the submodule commits not recorded yet in its superproject
        -- (since the merge base, the recorded commit may be on a diverged branch),
        -- as staged entries unless already listed by `git status`
        local commits = sub.base == '' and ''
            or ('; git -C %s diff --name-status --no-renames %s...HEAD | sed %s'):format(
                dir,
                sub.base,
                vim.fn.shellescape('s|^\\(.\\)\t|\\1  |')
            )
        cmds[#cmds + 1] = ('{ git -C %s %s%s; } | awk %s | sed %s'):format(
            dir,
            status,
            commits,
            vim.fn.shellescape('!seen[substr($0, 4)]++'),
            vim.fn.shellescape(('s|^\\(...\\)|\\1[%s] |'):format(label:gsub('[\\&|]', '\\%0')))
        )
    end

    local function run(selected, opts, args, skip)
        for _, s in ipairs(selected) do
            if not (skip and skip(s)) then
                local r = git_owner_exec(root, fzf_lua.path.entry_to_file(s, opts).path, args)
                if r.code ~= 0 then
                    fzf_lua.utils.error(r.stderr)
                end
            end
        end
    end

    fzf_lua.git_status({
        prompt = 'Git Status (submodules)> ',
        cwd = root,
        _fmt = {
            from = function(entry)
                return (
                    entry:gsub('%[([^%[%]]-)%] ', function(label)
                        return paths[label] and paths[label] .. '/'
                    end, 1)
                )
            end,
        },
        cmd = table.concat(cmds, '; '),
        previewer = vim.tbl_extend('force', fzf_lua.config.globals.previewers.git_diff, {
            cmd_modified = git_owner_preview(root, 'diff --color "$b" --'),
            cmd_deleted = git_owner_preview(root, 'diff --color "$b" --'),
        }),
        actions = {
            -- open the file on its first hunk (a multi-selection goes to the quickfix)
            ['enter'] = function(selected, opts)
                fzf_lua.actions.file_edit_or_qf(selected, opts)
                if #selected == 1 then
                    vim.schedule(function()
                        local u = require('utils')
                        u.goto_first_hunk(git_base(vim.fs.dirname(vim.api.nvim_buf_get_name(0))))
                    end)
                end
            end,
            ['left'] = {
                fn = function(selected, opts)
                    -- staging an already staged deletion errs, like fzf-lua's own git_stage
                    run(selected, opts, { 'add', '--' }, function(s)
                        return s:byte(1) == 68
                    end)
                end,
                reload = true,
            },
            ['right'] = {
                fn = function(selected, opts)
                    run(selected, opts, { 'reset', '--' })
                end,
                reload = true,
            },
            ['ctrl-x'] = {
                fn = function(selected, opts)
                    if fzf_lua.utils.confirm('Reset ' .. #selected .. ' file(s)?', '&Yes\n&No') ~= 1 then
                        return
                    end
                    for _, s in ipairs(selected) do
                        local file = fzf_lua.path.entry_to_file(s, opts).path
                        local tracked = git_owner_exec(root, file, { 'ls-files', '--error-unmatch', '--' }).code == 0
                        run({ s }, opts, tracked and { 'checkout', 'HEAD', '--' } or { 'clean', '-f', '--' })
                    end
                    vim.cmd('checktime')
                end,
                reload = true,
            },
        },
    })
end

---@type LazyPluginSpec
return {
    'ibhagwan/fzf-lua',
    dependencies = {
        'nvim-mini/mini.icons',
    },
    cmd = 'FzfLua',
    keys = {
        { '<space>F', ':FzfLua<cr>' },
        {
            '<leader>gi',
            function()
                require('fzf-lua').lsp_implementations()
            end,
            desc = 'List Implementation',
        },
        {
            'gb',
            function()
                require('fzf-lua').buffers({ cwd_only = true })
            end,
            desc = 'Buffers (cwd)',
        },
        {
            'gB',
            function()
                require('fzf-lua').buffers({ cwd_only = false })
            end,
            desc = 'Buffers (all)',
        },
        {
            '<space>ff',
            function()
                require('fzf-lua').files()
            end,
            desc = 'Find Files',
        },
        { '<leader>gS', git_status_recursive, desc = 'Git Status + submodules' },
    },
    ---@type fzf-lua.Config
    opts = function()
        local fzf_lua = require('fzf-lua')

        return {
            'skim',
            defaults = { formatter = { 'path.dirname_first', v = 2 } },
            grep = {
                fzf_opts = { ['--history'] = vim.fs.joinpath(vim.fn.stdpath('data'), 'fzf_search_hist') },
            },
            winopts = {
                fullscreen = true,
            },
            keymap = {
                fzf = {
                    ['ctrl-u'] = 'half-page-up',
                    ['ctrl-d'] = 'half-page-down',
                    ['ctrl-x'] = 'jump',
                    ['ctrl-f'] = 'preview-page-down',
                    ['ctrl-b'] = 'preview-page-up',
                    ['ctrl-s down'] = 'preview-page-down',
                    ['ctrl-up'] = 'preview-page-up',
                },
                builtin = {
                    ['<c-f>'] = 'preview-page-down',
                    ['<c-b>'] = 'preview-page-up',
                },
            },
            -- buffers = {
            --     formatter = 'path.filename_first',
            -- },
            actions = {
                files = {
                    ['enter'] = FzfLua.actions.file_edit_or_qf,
                    ['ctrl-s'] = FzfLua.actions.file_split,
                    ['ctrl-v'] = FzfLua.actions.file_vsplit,
                    ['ctrl-t'] = FzfLua.actions.file_tabedit,
                    ['alt-q'] = FzfLua.actions.file_sel_to_qf,
                    ['alt-Q'] = FzfLua.actions.file_sel_to_ll,
                    ['alt-i'] = FzfLua.actions.toggle_ignore,
                    ['alt-h'] = FzfLua.actions.toggle_hidden,
                    ['alt-f'] = FzfLua.actions.toggle_follow,
                    -- Select all + send to quickfix (works with both fzf and skim,
                    -- unlike a hand-written `select-all+accept` bind in keymap.fzf).
                    ['ctrl-q'] = { fn = fzf_lua.actions.file_sel_to_qf, prefix = 'select-all' },
                },
            },
            helptags = {
                actions = {
                    -- Open help pages in a vertical split.
                    ['enter'] = require('fzf-lua.actions').help_vert,
                },
            },
            lsp = {
                includeDeclaration = false, -- include current declaration in LSP context
                symbols = {
                    -- lsp_query      = "foo"       -- query passed to the LSP directly
                    -- query          = "bar"       -- query passed to fzf prompt for fuzzy matching
                    locate = false, -- attempt to position cursor at current symbol
                    symbol_style = 1, -- symbols style. false: disable, 1: icon+kind, 2: icon only, 3: kind only
                    fzf_opts = { ['--tiebreak'] = 'begin' },
                },
                code_actions = {
                    previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
                },
                finder = {
                    { 'skim' },
                    providers = {
                        { 'definitions', prefix = fzf_lua.utils.ansi_codes.green('def ') },
                        { 'declarations', prefix = fzf_lua.utils.ansi_codes.magenta('decl') },
                        { 'implementations', prefix = fzf_lua.utils.ansi_codes.green('impl') },
                        { 'typedefs', prefix = fzf_lua.utils.ansi_codes.red('tdef') },
                        { 'references', prefix = fzf_lua.utils.ansi_codes.blue('ref ') },
                        { 'incoming_calls', prefix = fzf_lua.utils.ansi_codes.cyan('in  ') },
                        { 'outgoing_calls', prefix = fzf_lua.utils.ansi_codes.yellow('out ') },
                        { 'type_sub', prefix = fzf_lua.utils.ansi_codes.cyan('sub ') },
                        { 'type_super', prefix = fzf_lua.utils.ansi_codes.yellow('supr') },
                    },
                },
            },
        }
    end,
}
