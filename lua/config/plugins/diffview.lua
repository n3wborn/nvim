local opts = {
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
}

require('diffview').setup(opts)

vim.keymap.set('n', '<leader><leader>v', function()
    if next(require('diffview.lib').views) == nil then
        vim.cmd('DiffviewOpen')
    else
        vim.cmd('DiffviewClose')
    end
end)

vim.keymap.set('n', '<leader>hD', function()
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
end)
