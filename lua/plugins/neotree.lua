return {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    keys = {
        {
            '<leader>fe',
            function()
                require('neo-tree.command').execute({ toggle = true })
            end,
            desc = 'Explorer NeoTree',
        },
        {
            '<leader>fE',
            function()
                require('neo-tree.command').execute({ toggle = true, dir = vim.uv.cwd() })
            end,
            desc = 'Explorer NeoTree (cwd)',
        },
        { '<leader>e', '<leader>fe', desc = 'Explorer NeoTree (Root Dir)', remap = true },
        { '<leader>E', '<leader>fE', desc = 'Explorer NeoTree (cwd)', remap = true },
        {
            '<leader>ge',
            function()
                require('neo-tree.command').execute({ source = 'git_status', toggle = true })
            end,
            desc = 'Git Explorer',
        },
        {
            '<leader>be',
            function()
                require('neo-tree.command').execute({ source = 'buffers', toggle = true })
            end,
            desc = 'Buffer Explorer',
        },
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
        -- because `cwd` is not set up properly.
        vim.api.nvim_create_autocmd('BufEnter', {
            group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
            desc = 'Start Neo-tree with directory',
            once = true,
            callback = function()
                if package.loaded['neo-tree'] then
                    return
                else
                    local stats = vim.uv.fs_stat(vim.fn.argv(0))
                    if stats and stats.type == 'directory' then
                        require('neo-tree')
                    end
                end
            end,
        })
    end,
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        event_handlers = {
            {
                event = 'file_open_requested',
                handler = function()
                    require('neo-tree.command').execute({ action = 'close' })
                end,
            },
        },
        sources = { 'filesystem', 'buffers', 'git_status' },
        open_files_do_not_replace_types = { 'terminal', 'qf', 'Outline' },
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
        },
        close_if_last_window = true,
        window = {
            mappings = {
                ['l'] = 'open',
                ['h'] = 'close_node',
                ['<c-s>'] = function(state)
                    require('neo-tree.sources.filesystem.commands').open_split(state)
                end,
                ['<c-v>'] = function(state)
                    require('neo-tree.sources.filesystem.commands').open_vsplit(state)
                end,
                ['<c-t>'] = function(state)
                    require('neo-tree.sources.filesystem.commands').open_tabnew(state)
                end,
                ['<space>'] = 'none',
                ['Y'] = {
                    function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        vim.fn.setreg('+', path, 'c')
                    end,
                    desc = 'Copy Path to Clipboard',
                },
                ['O'] = {
                    function(state)
                        require('lazy.util').open(state.tree:get_node().path, { system = true })
                    end,
                    desc = 'Open with System Application',
                },
                ['P'] = { 'toggle_preview', config = { use_float = false } },
            },
        },
    },
    config = function(_, opts)
        local function on_move(data)
            Snacks.rename.on_rename_file(data.source, data.destination)
        end

        local events = require('neo-tree.events')
        opts.event_handlers = opts.event_handlers or {}
        vim.list_extend(opts.event_handlers, {
            { event = events.FILE_MOVED, handler = on_move },
            { event = events.FILE_RENAMED, handler = on_move },
        })
        require('neo-tree').setup(opts)
        vim.api.nvim_create_autocmd('TermClose', {
            pattern = '*lazygit',
            callback = function()
                if package.loaded['neo-tree.sources.git_status'] then
                    require('neo-tree.sources.git_status').refresh()
                end
            end,
        })
    end,
}
