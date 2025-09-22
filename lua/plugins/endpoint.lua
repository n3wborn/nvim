---@type LazyPluginSpec
return {
    'zerochae/endpoint.nvim',
    dependencies = {
        'folke/snacks.nvim', -- For snacks picker
    },
    cmd = { 'Endpoint' },
    opts = {
        -- New improved config structure (v1.1+)
        cache = {
            mode = 'none', -- "none", "session", "persistent"
        },
        picker = {
            type = 'telescope', -- "telescope", "vim_ui_select", "snacks"
            options = {
                telescope = { theme = 'dropdown' },
                snacks = { preview = 'file' },
            },
        },
        ui = {
            show_icons = false,
            show_method = true,
            -- methods = {
            --     GET = { icon = '📥', color = 'TelescopeResultsNumber' },
            --     POST = { icon = '📤', color = 'TelescopeResultsConstant' },
            --     PUT = { icon = '✏️', color = 'TelescopeResultsKeyword' },
            --     DELETE = { icon = '🗑️', color = 'TelescopeResultsSpecialChar' },
            --     PATCH = { icon = '🔧', color = 'TelescopeResultsFunction' },
            -- },
        },

        frameworks = {
            rails = {
                display_format = 'smart',
                show_action_annotation = true,
            },
        },
    },
    config = function()
        require('endpoint').setup()
    end,
}
