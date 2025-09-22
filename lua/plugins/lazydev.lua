---@type LazyPluginSpec
return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            runtime = vim.env.VIMRUNTIME,--[[@as string]]
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                -- Only load the lazyvim library when the `LazyVim` global is found
                { path = 'LazyVim', words = { 'LazyVim' } },
                'snacks.nvim',
            },
            integrations = {
                -- Fixes lspconfig's workspace management for LuaLS
                -- Only create a new workspace if the buffer is not part
                -- of an existing workspace or one of its libraries
                lspconfig = true,
                -- add the cmp source for completion of:
                -- `require "modname"`
                -- `---@module "modname"`
                cmp = true,
            },
            -- disable when a .luarc.json file is found (eg: for emmylua_ls)
            enabled = function(root_dir)
                return not vim.uv.fs_stat(root_dir .. '/.luarc.json')
            end,
        },
    },
    { -- optional cmp completion source for require statements and module annotations
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = 'lazydev',
                group_index = 0,
                priority = 1000,
            })
        end,
    },
}
