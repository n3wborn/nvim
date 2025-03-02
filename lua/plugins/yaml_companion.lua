return {
    'someone-stole-my-name/yaml-companion.nvim',
    dependencies = {
        { 'neovim/nvim-lspconfig' },
        { 'nvim-lua/plenary.nvim' },
    },
    opts = {
        -- Built in file matchers
        builtin_matchers = {
            -- Detects Kubernetes files based on content
            kubernetes = { enabled = true },
            cloud_init = { enabled = true },
        },

        -- Additional schemas available in Telescope picker
        schemas = {
            --{
            --name = "Kubernetes 1.22.4",
            --uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
            --},
        },

        -- Pass any additional options that will be merged in the final LSP config
        lspconfig = {
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
                redhat = { telemetry = { enabled = false } },
                yaml = {
                    validate = true,
                    format = { enable = true },
                    hover = true,
                    schemaStore = {
                        enable = true,
                        url = 'https://www.schemastore.org/api/json/catalog.json',
                    },
                    schemaDownload = { enable = true },
                    schemas = {},
                    trace = { server = 'debug' },
                },
            },
        },
    },
    config = function(_, opts)
        require('yaml-companion').setup(opts)

        vim.keymap.set('n', '<space>gs', function()
            local schema = require('yaml-companion').get_buf_schema(0)
            if schema.result[1].name == 'none' then
                return ''
            end
            return schema.result[1].name
        end, { desc = 'Get current buffer schema' })

        vim.keymap.set('n', '<space>ss', function()
            require('yaml-companion').open_ui_select()
        end, { desc = 'Set current buffer schema' })
    end,
}
