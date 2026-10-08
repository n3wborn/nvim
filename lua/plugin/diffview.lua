local add = require('vim-pack').add

--- Toggle Diffview: close it when open, otherwise open the file history (or the diff on an unnamed buffer).
---@param current_file boolean Restrict the file history to the current file
local function toggle_file_history(current_file)
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
    elseif current_file then
        vim.cmd('DiffviewFileHistory ' .. vim.fn.fnameescape(file))
    else
        vim.cmd('DiffviewFileHistory')
    end
end

add({
    {
        src = 'dlyongemallo/diffview-plus.nvim',
        module_name = 'diffview',
        opts = {
            auto_close_on_empty = true,
            hide_merge_artifacts = true,
            clean_up_buffers = true,
            default_args = {
                DiffviewOpen = { '--imply-local' },
            },
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
        on_setup = function()
            vim.keymap.set('n', '<leader><leader>v', function()
                if next(require('diffview.lib').views) == nil then
                    vim.cmd('DiffviewOpen')
                else
                    vim.cmd('DiffviewClose')
                end
            end, { desc = require('config.icons').git.git .. ' Diff This' })
            vim.keymap.set('n', '<leader>hd', function()
                toggle_file_history(false)
            end, { desc = 'Toggle DiffviewFileHistory' })
            vim.keymap.set('n', '<leader>hD', function()
                toggle_file_history(true)
            end, { desc = 'Toggle DiffviewFileHistory on current file' })
        end,
    },
})
