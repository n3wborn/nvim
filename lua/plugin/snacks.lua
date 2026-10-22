local add = require('vim-pack').add

add({
    {
        src = 'folke/snacks.nvim',
        ---@type snacks.Config
        opts = {
            animate = { enabled = false },
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            image = { enabled = true },
            indent = { enabled = false },
            input = { enabled = false },
            lazygit = { enabled = false },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            scope = { enabled = false }, -- already handled blink indent
            picker = {
                layout = { fullscreen = true },
                previewers = { diff = { builtin = false }, git = { builtin = false } },
                sources = { files = { hidden = true }, grep = { hidden = true } },
            },
        },
        on_setup = function()
            -- Setup some globals for debugging
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
            -- Indent guides are drawn by blink.indent, not Snacks
            Snacks.toggle
                .new({
                    name = 'Indent Guides',
                    get = function()
                        return require('blink.indent').is_enabled()
                    end,
                    set = function(state)
                        require('blink.indent').enable(state)
                    end,
                })
                :map('<leader>ug')
            Snacks.toggle.dim():map('<leader>uD')

            -- stylua: ignore start
            -- LSP
            vim.keymap.set('n', '<space>s', function() Snacks.picker.lsp_symbols() end, { desc = 'List Symbols' })

            -- search pickers
            vim.keymap.set('n', '<leader>sd', function() Snacks.picker.grep_word() end, { desc = 'Search current word' })
            vim.keymap.set('n', '<leader>sD', function() Snacks.picker.grep_word({ hidden = true, ignored = true, }) end, { desc = 'Search current word' })
            vim.keymap.set('n', '<leader>sp', function() Snacks.picker.grep() end, { desc = 'Grep' })
            vim.keymap.set('n', '<leader>sP', function() Snacks.picker.grep({ hidden = true, ignored = true }) end, { desc = 'git grep' })
            vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'List Files' })
            vim.keymap.set('n', '<leader>fF', function() Snacks.picker.files({ hidden = true, ignored = true }) end, { desc = 'List Files' })
            vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'List Recent Files' })
            vim.keymap.set('n', '<space>S', function() Snacks.picker.smart({ multi = { 'recent', 'files' } }) end, { desc = 'Smart Picker' })

            -- buffer / marks / registers /mappings
            vim.keymap.set('n', '<leader>gj', function() Snacks.picker.jumps() end, { desc = 'List Jumps' })
            vim.keymap.set('n', '<leader>gm', function() Snacks.picker.marks() end, { desc = 'List Marks' })
            vim.keymap.set('n', '<leader>gr', function() Snacks.picker.registers() end, { desc = 'List Registers' })
            vim.keymap.set('n', '<leader>k', function() Snacks.picker.keymaps() end, { desc = 'List mappings' })

            -- zen
            vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
            vim.keymap.set('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = 'Toggle Zoom' })

            vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })
            vim.keymap.set('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = 'Rename File' })

            -- git
            vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
            vim.keymap.set('n', '<leader>gb', function() Snacks.picker.git_branches() end, { desc = 'Git Branches' })
            vim.keymap.set('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = 'git log' })
            vim.keymap.set('n', '<leader>gL', function() Snacks.picker.git_log_line() end, { desc = 'git log line' })
            vim.keymap.set('n', '<leader>gF', function() Snacks.picker.git_log_file() end, { desc = 'git log file' })
            vim.keymap.set('n', '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })

            -- scratch
            vim.keymap.set('n', '<leader>.', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
            vim.keymap.set('n', '<leader>S', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
            vim.keymap.set('n', '<leader>dps', function() Snacks.profiler.scratch() end, { desc = 'Profiler Scratch Buffer' })

            -- notifier
            vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Notification History' })
            vim.keymap.set('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })

            vim.keymap.set('n', '<leader>sa', function()
                Snacks.picker.grep({
                    search = vim.fn.expand('<cword>'),
                    args = {
                        '--fixed-strings',
                        '--glob',
                        '*lock.json',
                    },
                })
            end, { desc = 'Search current word' })
            -- stylua: ignore end
        end,
    },
})
