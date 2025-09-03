---@type LazyPluginSpec
return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            runtime = vim.env.VIMRUNTIME,--[[@as string]]
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
                lspconfig = false,
                -- add the cmp source for completion of:
                -- `require "modname"`
                -- `---@module "modname"`
                cmp = true,
            },
        },
    },
}
