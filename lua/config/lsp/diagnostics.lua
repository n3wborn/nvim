local M = {}

local diagnostic_icons = require('config.icons').diagnostics

function M.setup()
    ---@type vim.diagnostic.Opts
    vim.diagnostic.config({
        status = {
            format = function(counts)
                local items = {}
                for severity, count in pairs(counts) do
                    local name = vim.diagnostic.severity[severity]
                    local hl = 'DiagnosticSign' .. name:sub(1, 1) .. name:sub(2):lower()
                    table.insert(items, ('%%#%s#%s %d'):format(hl, diagnostic_icons[name], count))
                end
                return table.concat(items, ' ')
            end,
        },

        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
                [vim.diagnostic.severity.WARN] = diagnostic_icons.Warn,
                [vim.diagnostic.severity.HINT] = diagnostic_icons.Hint,
                [vim.diagnostic.severity.INFO] = diagnostic_icons.Info,
            },
        },
        severity_sort = true,
        underline = false,
        update_in_insert = true,
        -- TODO: choose which one is better
        -- update_in_insert = false,
        float = {
            source = 'if_many',
            -- Show severity icons as prefixes.
            prefix = function(diag)
                local level = vim.diagnostic.severity[diag.severity]
                local prefix = string.format(' %s ', diagnostic_icons[level])
                return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
            end,
        },
        jump = { on_jump = vim.diagnostic.open_float },
        virtual_lines = {
            current_line = true,
            severity = {
                vim.diagnostic.severity.WARN,
                vim.diagnostic.severity.ERROR,
            },
        },
    })
end

return M
