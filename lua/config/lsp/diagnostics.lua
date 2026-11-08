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
        -- Show the diagnostic in a float after each jump (]d, [d, ]D, [D, ]e, ...)
        jump = {
            on_jump = function(diagnostic, bufnr)
                if not diagnostic then
                    return
                end
                vim.diagnostic.open_float({ bufnr = bufnr, scope = 'cursor', focus = false })
            end,
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
                local name = level:sub(1, 1) .. level:sub(2):lower()
                local prefix = string.format(' %s ', diagnostic_icons[name])
                return prefix, 'Diagnostic' .. name
            end,
        },
    })
end

return M
