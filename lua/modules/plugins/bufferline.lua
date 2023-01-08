-- https://github.com/akinsho/bufferline.nvim/tree/v3.0.0

local signs = require('modules.lsp.diagnostics').signs

signs = {
    error = signs.Error,
    warning = signs.Warn,
    info = signs.Info,
    hint = signs.Hint,
}

local severities = {
    'error',
    'warning',
    -- "info",
    -- "hint",
}

require('bufferline').setup({
    options = {
        mode = 'tabs',
        show_close_icon = true,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        separator_style = 'default',
        diagnostics_indicator = function(_, _, diag)
            local s = {}
            for _, severity in ipairs(severities) do
                if diag[severity] then
                    table.insert(s, signs[severity] .. diag[severity])
                end
            end
            return table.concat(s, ' ')
        end,
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'NvimTree',
                highlight = 'Directory',
                text_align = 'center',
                separator = true,
            },
        },
    },
})
