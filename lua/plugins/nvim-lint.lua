---@diagnostic disable: need-check-nil
---@type LazyPluginSpec
return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },

    opts = {
        events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
        linters_by_ft = {
            gitcommit = { 'gitlint' },
            php = { 'php' },
            python = { 'ruff' },
            zig = { 'zlint' },
        },
        linters = {},
    },

    config = function(_, opts)
        local lint = require('lint')
        local M = {}

        function M.debounce(ms, fn)
            local timer = vim.uv.new_timer()

            return function(...)
                local argv = { ... }

                timer:start(ms, 0, function()
                    timer:stop()
                    vim.schedule_wrap(fn)(unpack(argv))
                end)
            end
        end

        do
            local native_phpcs = lint.linters.phpcs

            if native_phpcs then
                local phpcs = vim.deepcopy(native_phpcs)

                phpcs.cmd = function()
                    local filename = vim.api.nvim_buf_get_name(0)
                    local dirname = vim.fs.dirname(filename)

                    local local_phpcs = vim.fs.find('vendor/bin/phpcs', {
                        upward = true,
                        path = dirname,
                        type = 'file',
                    })[1]

                    if local_phpcs then
                        return local_phpcs
                    end

                    return 'phpcs'
                end

                phpcs.args = {
                    '-q',
                    '--report=json',

                    function()
                        local filename = vim.api.nvim_buf_get_name(0)

                        return '--stdin-path=' .. vim.fn.fnamemodify(filename, ':p:.')
                    end,

                    function()
                        local filename = vim.api.nvim_buf_get_name(0)
                        local dirname = vim.fs.dirname(filename)

                        local config = vim.fs.find({
                            'phpcs.xml',
                            'phpcs.xml.dist',
                            '.phpcs.xml',
                            '.phpcs.xml.dist',
                        }, {
                            upward = true,
                            path = dirname,
                            type = 'file',
                        })[1]

                        if config then
                            return '--standard=' .. config
                        end

                        return '--standard=PSR12'
                    end,

                    '-',
                }

                lint.linters.phpcs = phpcs
            end
        end

        for name, linter in pairs(opts.linters) do
            if name ~= 'phpcs' then
                if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
                    lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter)

                    if type(linter.prepend_args) == 'table' then
                        lint.linters[name].args = lint.linters[name].args or {}

                        vim.list_extend(lint.linters[name].args, linter.prepend_args)
                    end
                else
                    lint.linters[name] = linter
                end
            end
        end

        lint.linters_by_ft = opts.linters_by_ft

        function M.lint()
            -- Use nvim-lint's logic first:
            -- * checks if linters exist for the full filetype first
            -- * otherwise will split filetype by "." and add all those linters
            -- * this differs from conform.nvim which only uses the first
            --   filetype that has a formatter
            local names = lint._resolve_linter_by_ft(vim.bo.filetype)

            -- Create a copy of the names table to avoid modifying the original.
            names = vim.list_extend({}, names)

            -- Add fallback linters.
            if #names == 0 then
                vim.list_extend(names, lint.linters_by_ft['_'] or {})
            end

            -- Add global linters.
            vim.list_extend(names, lint.linters_by_ft['*'] or {})

            -- Filter out linters that don't exist or don't match the condition.
            local ctx = {
                filename = vim.api.nvim_buf_get_name(0),
            }

            ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')

            names = vim.tbl_filter(function(name)
                local linter = lint.linters[name]

                if not linter then
                    vim.notify('Linter not found: ' .. name, { title = 'nvim-lint' })
                end

                return linter and not (type(linter) == 'table' and linter.condition and not linter.condition(ctx))
            end, names)

            -- Run linters.
            if #names > 0 then
                lint.try_lint(names)
            end
        end

        vim.api.nvim_create_autocmd(opts.events, {
            group = vim.api.nvim_create_augroup('nvim-lint', {
                clear = true,
            }),
            callback = M.debounce(100, M.lint),
        })
    end,
}
