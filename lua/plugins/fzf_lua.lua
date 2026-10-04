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

--- Same as git_owner_exec, as a shell command for fzf previews ({file} is substituted by fzf-lua).
local function git_owner_preview(root, args)
    return (
        [[cd %s && sh -c 'f=$(realpath -m -- "$1"); d=$(dirname -- "$f"); ]]
        .. [[while [ ! -d "$d" ]; do d=$(dirname -- "$d"); done; git -C "$d" %s "$f"' _ {file}]]
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
    local subs = vim.system(
        { 'git', 'submodule', 'foreach', '--recursive', '--quiet', 'printf "%s\\t%s\\n" "$name" "$displaypath"' },
        { cwd = root, text = true }
    ):wait()
    local list, count, paths = {}, {}, {}
    for name, path in (subs.stdout or ''):gmatch('([^\t\n]+)\t([^\n]+)') do
        list[#list + 1] = { name = name, path = path }
        count[name] = (count[name] or 0) + 1
    end
    local cmds = { ('git -C %s %s'):format(vim.fn.shellescape(root), status) }
    for _, sub in ipairs(list) do
        local label = count[sub.name] == 1 and sub.name or sub.path
        paths[label] = sub.path
        cmds[#cmds + 1] = ('git -C %s %s | sed %s'):format(
            vim.fn.shellescape(vim.fs.joinpath(root, sub.path)),
            status,
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
            cmd_modified = git_owner_preview(root, 'diff --color HEAD --'),
            cmd_deleted = git_owner_preview(root, 'diff --color HEAD --'),
        }),
        actions = {
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
