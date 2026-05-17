---@type LazyPluginSpec
return {
    'DrKJeff16/project.nvim',
    dependencies = {
        'ibhagwan/fzf-lua',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    ---@module "project"
    ---@type Project.Config
    ---@return Project.Config
    opts = function()
        local expand = require('project.util').strip_slash

        return {
            fzf_lua = {
                enabled = false,
                show = 'paths', ---@type 'paths'|'names'
                sort = 'newest', ---@type 'newest'|'oldest'
            },
            custom_projects = {
                { path = expand('~/prog/git'), name = 'Prog Git' },
                { path = expand('~/.config/nvim'), name = 'Nvim Config' },
                { path = expand('~/.config/nvim-pack/'), name = 'Nvim Pack Config' },
            },
        }
    end,
}
