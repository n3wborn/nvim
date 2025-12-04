-- stylua: ignore
---@type LazyPluginSpec
return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.plugins.Config
    opts = {
        animate = { enabled = true, duration = 10 },
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        ---@type snacks.lazygit.Config
        lazygit = { enabled = true, interactive = true },
        notifier = {
            -- log level: TRACE DEBUG ERROR WARN INFO  OFF
            level = vim.log.levels.WARN,
            win = { preview = { wo = { wrap = true } } },
        },
        quickfile = { enabled = true },
        scroll = {
            enabled = true,
            keys = {
                ---@type table<string, snacks.scope.TextObject|{desc?:string}|false>
                textobject = {
                    ii = {
                        min_size = 2, -- minimum size of the scope
                        edge = false, -- inner scope
                        cursor = false,
                        treesitter = { blocks = { enabled = false } },
                        desc = "inner scope",
                    },
                    ai = {
                        cursor = false,
                        min_size = 2, -- minimum size of the scope
                        treesitter = { blocks = { enabled = false } },
                        desc = "full scope",
                    },
                },
                ---@type table<string, snacks.scope.Jump|{desc?:string}|false>
                jump = {
                    ["[i"] = {
                        min_size = 1, -- allow single line scopes
                        bottom = false,
                        cursor = false,
                        edge = true,
                        treesitter = { blocks = { enabled = false } },
                        desc = "jump to top edge of scope",
                    },
                    ["]i"] = {
                        min_size = 1, -- allow single line scopes
                        bottom = true,
                        cursor = false,
                        edge = true,
                        treesitter = { blocks = { enabled = false } },
                        desc = "jump to bottom edge of scope",
                    },
                },
            },
        },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        scope = { enabled = true },
        picker = {
            layouts = {
                preset = "vscode",
            },
        },
    },
    keys = {
        { "<space>s",    function() Snacks.picker.lsp_symbols() end, desc = "List Symbols" },
        { "<leader>sd",  function() Snacks.picker.grep_word() end, desc = "Search current word" },
        { "<leader>sp",  function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sP",  function() Snacks.picker.git_grep() end, desc = "git grep" },
        { "<leader>ff",  function() Snacks.picker.files() end, desc = "List Files" },
        { "<leader>fr",  function() Snacks.picker.recent() end, desc = "List Recent Files" },
        {
            "<space>S",
            function()
                Snacks.picker.smart({
                    multi = { "recent", "files" },
                    matcher = { cwd_bonus = true, frecency = true, sort_empty = true },
                })
            end,
            desc = "Smart Picker",
        },
        { "gb",          function() Snacks.picker.buffers() end, desc = "List Buffers" },
        { "<leader>gj",  function() Snacks.picker.jumps() end, desc = "List Jumps" },
        { "<leader>gm",  function() Snacks.picker.marks() end, desc = "List Marks" },
        { '<leader>gr',  function() Snacks.picker.registers() end, desc = "List Registers" },
        { "<leader>k",   function() Snacks.picker.keymaps() end, desc = "List mappings" },
        { "<leader>sR",  function() Snacks.picker.resume() end, desc = "Resume" },
        { "<space>R",    function() Snacks.picker.resume() end, desc = "Resume" },
        { "<leader>z",   function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>Z",   function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
        { "<leader>.",   function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>S",   function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
        { "<leader>n",   function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>bd",  function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>cR",  function() Snacks.rename.rename_file() end, desc = "Rename File" },
        { "<leader>gB",  function() Snacks.gitbrowse() end, desc = "Git Browse" },
        -- { "<leader>gb",  function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
        { "<leader>gb",  function() Snacks.picker.git_log_line({ preview = "git_show" }) end, desc = "Git Log Line" },
        { "<leader>gd",  function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        { "<leader>gg",  function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>gl",  function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
        { "<leader>gs",  function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>un",  function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        { "]]",          function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
        { "[[",          function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },
    init = function()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'VeryLazy',
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
                Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
                Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
                Snacks.toggle.diagnostics():map('<leader>ud')
                Snacks.toggle.line_number():map('<leader>ul')
                Snacks.toggle.treesitter():map('<leader>T')
                Snacks.toggle
                    .option('background', { off = 'light', on = 'dark', name = 'Dark Background' })
                    :map('<leader>ub')
                Snacks.toggle.inlay_hints():map('<leader>P')
                Snacks.toggle.indent():map('<leader>ug')
                Snacks.toggle.dim():map('<leader>uD')
            end,
        })
    end,
}
