return {
    ---@type LazyPluginSpec
    {
        'dlyongemallo/diffview.nvim',
        cmd = {
            'DiffviewOpen',
            'DiffviewClose',
            'DiffviewRefresh',
            'DiffviewFileHistory',
            'DiffviewFocusFiles',
            'DiffviewToggleFiles',
        },
        keys = {
            {
                '<leader><leader>v',
                function()
                    if next(require('diffview.lib').views) == nil then
                        vim.cmd('DiffviewOpen')
                    else
                        vim.cmd('DiffviewClose')
                    end
                end,
                desc = require('config.icons').git.git .. ' Diff This',
            },
            {
                '<leader>hd',
                function()
                    local ok, lib = pcall(require, 'diffview.lib')
                    if not ok then
                        vim.notify('diffview.nvim not installed', vim.log.levels.WARN)
                        return
                    end

                    local view = lib.get_current_view()
                    if view then
                        vim.cmd('DiffviewClose')
                        return
                    end

                    local file = vim.api.nvim_buf_get_name(0)
                    if file == '' then
                        vim.cmd('DiffviewOpen')
                    else
                        vim.cmd('DiffviewFileHistory')
                    end
                end,
            },
            {
                '<leader>hD',
                function()
                    local ok, lib = pcall(require, 'diffview.lib')
                    if not ok then
                        vim.notify('diffview.nvim not installed', vim.log.levels.WARN)
                        return
                    end

                    local view = lib.get_current_view()
                    if view then
                        vim.cmd('DiffviewClose')
                        return
                    end

                    local file = vim.api.nvim_buf_get_name(0)
                    if file == '' then
                        vim.cmd('DiffviewOpen')
                    else
                        vim.cmd('DiffviewFileHistory ' .. vim.fn.fnameescape(file))
                    end
                end,
                desc = 'Toggle DiffviewFileHistory on current file',
            },
        },
        ---@module "diffview"
        ---@type DiffviewConfig
        opts = {
            use_icons = false,
            keymaps = {
                file_panel = {
                    {
                        'n',
                        'cc',
                        function()
                            vim.ui.input({ prompt = 'Commit message: ' }, function(msg)
                                if not msg then
                                    return
                                end
                                local results = vim.system({ 'git', 'commit', '-m', msg }, { text = true }):wait()

                                if results.code ~= 0 then
                                    vim.notify(
                                        'Commit failed with the message: \n'
                                            .. vim.trim(results.stdout .. '\n' .. results.stderr),
                                        vim.log.levels.ERROR,
                                        { title = 'Commit' }
                                    )
                                else
                                    vim.notify(results.stdout, vim.log.levels.INFO, { title = 'Commit' })
                                end
                            end)
                        end,
                    },
                },
            },
        },
    },
}
