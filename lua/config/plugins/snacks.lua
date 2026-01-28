-- stylua: ignore
return {
    src = 'https://github.com/folke/snacks.nvim',
    data = {
        setup = function()
            local opts = {
                animate = { enabled = true, duration = 10 },
                bigfile = { enabled = true },
                dashboard = { enabled = false },
                image = { enabled = true },
                indent = { enabled = true },
                input = { enabled = true },
                ---@type snacks.lazygit.Config
                lazygit = { enabled = true, interactive = true },
                notifier = {
                    -- log level: TRACE DEBUG ERROR WARN INFO  OFF
                    level = vim.log.levels.WARN,
                    win = { preview = { wo = { wrap = true } } },
                },
                quickfile = { enabled = false },
                scroll = { enabled = false },
                statuscolumn = { enabled = true },
                words = { enabled = true },
                scope = { enabled = true },
                ---@type snacks.picker
                picker = {
                    layout = {
                        fullscreen = true,
                    },
                    ---@type snacks.picker.projects.Config
                    projects = {
                        finder = "recent_projects",
                        format = "file",
                        dev = { "~/projects", '~/prog/git', '~/.config/' },
                        confirm = "load_session",
                        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "package.json", "Makefile" },
                        recent = true,
                        matcher = {
                            frecency = true, -- use frecency boosting
                            sort_empty = true, -- sort even when the filter is empty
                            cwd_bonus = false,
                        },
                        sort = { fields = { "score:desc", "idx" } },
                        win = {
                            preview = { minimal = true },
                            input = {
                                keys = {
                                    -- every action will always first change the cwd of the current tabpage to the project
                                    ["<c-e>"] = { { "tcd", "picker_explorer" }, mode = { "n", "i" } },
                                    ["<c-f>"] = { { "tcd", "picker_files" }, mode = { "n", "i" } },
                                    ["<c-g>"] = { { "tcd", "picker_grep" }, mode = { "n", "i" } },
                                    ["<c-r>"] = { { "tcd", "picker_recent" }, mode = { "n", "i" }, nowait = true },
                                    ["<c-w>"] = { { "tcd" }, mode = { "n", "i" } },
                                    ["<c-t>"] = {
                                        function(picker)
                                            vim.cmd("tabnew")
                                            Snacks.notify("New tab opened")
                                            picker:close()
                                            Snacks.picker.projects()
                                        end,
                                        mode = { "n", "i" },
                                    },
                                },
                            },
                        },
                    },

                },
            }

            require('snacks').setup(opts)

            -- stylua: ignore
            -- PICKERS
            vim.keymap.set('n', '<leader>sd', function() Snacks.picker.grep_word() end)
            vim.keymap.set('n', '<leader>sp', function() Snacks.picker.grep() end)
            vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end)
            vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end)
            vim.keymap.set('n', 'gb', function() Snacks.picker.buffers() end)
            vim.keymap.set('n', 'gj', function() Snacks.picker.jumps() end)
            vim.keymap.set('n', 'gm', function() Snacks.picker.marks() end)
            vim.keymap.set('n', 'gr', function() Snacks.picker.registers() end)
            vim.keymap.set('n', '<leader>k',  function() Snacks.picker.keymaps() end)
            vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end)
            vim.keymap.set('n', '<space>S', function()
                Snacks.picker.smart({
                    multi = { "recent", "files" },
                    matcher = { cwd_bonus = true, frecency = true, sort_empty = true },
                })
            end)

            -- GIT
            vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end)
            vim.keymap.set('n', '<leader>gd', function() Snacks.picker.git_diff() end)
            vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end)
            vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit.log() end)
            vim.keymap.set('n', '<leader>gL', function() Snacks.lazygit.log_file() end)
            vim.keymap.set('n', '<leader>gB', function() Snacks.gitbrowse() end)

            --- LSP
            vim.keymap.set('n', '<leader>gd', function() Snacks.picker.lsp_definitions() end)
            vim.keymap.set('n', '<leader>gr', function() Snacks.picker.lsp_references() end)
            vim.keymap.set('n', '<leader>gt', function() Snacks.picker.lsp_type_definitions() end)
            vim.keymap.set('n', '<leader>cs', function() Snacks.picker.lsp_symbols() end)

            --- DIV
            vim.keymap.set('n', '<leader>P',  function() Snacks.picker.projects() end)
            vim.keymap.set('n', '<leader>z',  function() Snacks.zen() end)
            vim.keymap.set('n', '<leader>Z',  function() Snacks.zen.zoom() end)
            vim.keymap.set('n', '<leader>n',  function() Snacks.notifier.show_history() end)
            vim.keymap.set('n', '<leader>un', function() Snacks.notifier.hide() end)
            vim.keymap.set('n', '<leader>.',  function() Snacks.scratch() end)
            vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end)
        end,
    },

}
