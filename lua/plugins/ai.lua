---@type LazyPluginSpec
return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    cmd = {
        'CodeCompanion',
        'CodeCompanionChat',
    },
    opts = {
        adapters = {
            anthropic = function()
                return require('codecompanion.adapters').extend('anthropic', {
                    schema = {
                        model = {
                            default = 'claude-sonnet-4-20250514',
                        },
                    },
                    env = {
                        api_key = 'ANTHROPIC_API_KEY',
                    },
                })
            end,
        },
        strategies = {
            chat = { adapter = 'anthropic' },
            inline = { adapter = 'anthropic' },
        },
    },
}
