---@type LazyPluginSpec
return {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    ---@module 'persistence'
    ---@type Persistence.Config
    opts = {
        need = 0,
    },
    -- stylua: ignore start
    keys = {
        { "<leader>qL", function() require("persistence").load() end, desc = "Load Session" },
        { "<leader>qS", function() require("persistence").save() end,desc = "Save Session" },
        { "<leader>qs", function() require("persistence").select() end,desc = "Select Session" },
        { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
        { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
    -- stylua: ignore end
    cond = vim.g.sessions_enabled,
}
