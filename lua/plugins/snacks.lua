-- stylua: ignore
---@type LazyPluginSpec
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        ---@type snacks.lazygit.Config
        lazygit = { enabled = true, interactive = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        scope = { enabled = true },
        styles = {
            notification = {
                relative = 'editor',
            }
        },
        picker = {
            layout = {
                preset = "vscode",  -- default, sidebar, telescope, ivy, ivy_split, dropdown, select, vscode
                cycle = true,
                preview = true,
                layout = {
                    width = 0.7,
                    height = 0.7,
                }
            },
            previewers = {
                file = {
                    max_size = 1024 * 1024, -- 1MB
                    max_line_length = 300, -- max line length
                    ft = nil, ---@type string? filetype for highlighting. Use `nil` for auto detect
                },
            },
            formatters = {
                text = {
                    ft = nil, ---@type string? filetype for highlighting
                },
                file = {
                    filename_first = false, -- display filename before the file path
                    truncate = 200, -- truncate the file path to (roughly) this length
                    filename_only = false, -- only show the filename
                    icon_width = 2, -- width of the icon (in characters)
                    git_status_hl = true, -- use the git status highlight group for the filename
                },
            },
        },
    },

    keys = {
        { "<leader>sd", function() Snacks.picker.grep_word() end, desc = "Search current word" },
        { "<leader>sp", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sP", function() Snacks.picker.git_grep() end, desc = "git grep" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "List Files" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "List Recent Files" },
        { "<space>S", function() Snacks.picker.smart({ multi = { "recent", "files" },  matcher = {cwd_bonus = false, frecency = true, sort_empty = true} }) end, desc = "Smart Picker" },
        { "gb",         function() Snacks.picker.buffers() end, desc = "List Buffers" },
        { "<leader>gj", function() Snacks.picker.jumps() end, desc = "List Jumps" },
        { "<leader>gm", function() Snacks.picker.marks() end, desc = "List Marks" },
        { '<leader>gr', function() Snacks.picker.registers() end, desc = "List Registers" },
        { "<leader>k", function() Snacks.picker.keymaps() end, desc = "List mappings" },
        { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
        { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
        { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    },
    init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
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
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                    Snacks.toggle.treesitter():map("<leader>T")
                    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
                    Snacks.toggle.inlay_hints():map("<leader>P")
                    Snacks.toggle.indent():map("<leader>ug")
                    Snacks.toggle.dim():map("<leader>uD")
                end,
            })
        end
}
