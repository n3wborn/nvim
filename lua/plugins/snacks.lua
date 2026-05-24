-- stylua: ignore
---@type LazyPluginSpec
return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        animate = { enabled = true, duration = 10 },
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        image = { enabled = true },
        indent = { enabled = false },
        input = { enabled = false },
        lazygit = { enabled = false},
        notifier = { enabled = true },
        quickfile = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = true },
        scope = { enabled = true },
        picker = {
            layout = { fullscreen = true },
            previewers = { diff = { builtin = false }, git = { builtin = false } },
            sources = { files = { hidden = true }, grep = { hidden = true } },
        },
    },
    keys = {
        -- LSP
        { "<space>s",   function() Snacks.picker.lsp_symbols() end, desc = "List Symbols" },

        -- search pickers
        { "<leader>sd", function() Snacks.picker.grep_word() end, desc = "Search current word" },
        { "<leader>sD", function() Snacks.picker.grep_word({ hidden = true, ignored = true, }) end, desc = "Search current word" },
        { "<leader>sp", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sP", function() Snacks.picker.grep({ hidden = true, ignored = true }) end, desc = "git grep" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "List Files" },
        { "<leader>fF", function() Snacks.picker.files({ hidden = true, ignored = true }) end, desc = "List Files" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "List Recent Files" },
        { "<space>S",   function() Snacks.picker.smart({ multi = { "recent", "files" } }) end, desc = "Smart Picker" },

        -- buffer / marks / registers /mappings
        { "<leader>gj",  function() Snacks.picker.jumps() end, desc = "List Jumps" },
        { "<leader>gm",  function() Snacks.picker.marks() end, desc = "List Marks" },
        { '<leader>gr',  function() Snacks.picker.registers() end, desc = "List Registers" },
        { "<leader>k",   function() Snacks.picker.keymaps() end, desc = "List mappings" },

        -- zen
        { "<leader>z",   function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>Z",   function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },

        { "<leader>bd",  function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>cR",  function() Snacks.rename.rename_file() end, desc = "Rename File" },

        -- git
        { "<leader>gs",  function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>gb",  function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gl",  function() Snacks.picker.git_log() end, desc = "git log" },
        { "<leader>gL",  function() Snacks.picker.git_log_line() end, desc = "git log line" },
        { "<leader>gF",  function() Snacks.picker.git_log_file() end, desc = "git log file" },
        { "<leader>gB",  function() Snacks.gitbrowse() end, desc = "Git Browse" },

        -- scratch
        { "<leader>.",   function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>S",   function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },

        -- notifier
        { "<leader>n",   function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>un",  function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

        {
            "<leader>sa",
            function()
                require("snacks").picker.grep({
                    search = vim.fn.expand("<cword>"),
                    args = {
                        "--fixed-strings",
                        "--glob",
                        "*lock.json",
                    },
                })
            end,
            desc = "Search current word" }
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
                -- Snacks.toggle.treesitter():map('<leader>T')
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
