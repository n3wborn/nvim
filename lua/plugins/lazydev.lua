return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            runtime = vim.env.VIMRUNTIME --[[@as string]],
            library = {
                -- Only load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                -- always load the LazyVim library
                'lazy.nvim',
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
        },
    },
    { -- optional cmp completion source for require statements and module annotations
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = 'lazydev',
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
}
