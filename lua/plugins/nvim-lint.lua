return {
    'mfussenegger/nvim-lint',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' }, -- to disable, comment this out
    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            -- gitcommit = { 'gitlint' }, -- seems to break, maybe havce to check the docs (http://jorisroovers.github.io/gitlint)
            javascript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            php = { 'php' },
            typescript = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
        }

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = vim.api.nvim_create_augroup('lint', { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set('n', '<leader>l', function()
            lint.try_lint()
        end, { desc = 'Trigger linting for current file' })
    end,
}
