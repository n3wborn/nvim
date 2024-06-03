local M = {}

function M.setup()
    local signs = require('custom.icons').diagnostics
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = signs.Error,
                [vim.diagnostic.severity.WARN] = signs.Warn,
                [vim.diagnostic.severity.HINT] = signs.Hint,
                [vim.diagnostic.severity.INFO] = signs.Info,
            },
        },
        virtual_text = false,
        severity_sort = true,
        underline = false,
        update_in_insert = true,
        jump = { float = true },
        float = _G.global.float_border_opts,
    })
end

return M
