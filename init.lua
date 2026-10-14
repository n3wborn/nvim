vim.loader.enable()

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.sessions_enabled = true

-- Disable some builtin plugins (was handled by lazy.nvim's performance.rtp.disabled_plugins).
for _, plugin in ipairs({ 'gzip', 'tarPlugin', 'tohtml', 'zipPlugin', 'netrwPlugin', 'matchit', 'matchparen', 'tutor' }) do
    vim.g['loaded_' .. plugin] = 1
end
vim.g.loaded_netrw = 1

-- Load every plugin spec from lua/plugin/, in alphabetical order.
local plugin_dir = vim.fs.joinpath(vim.fn.stdpath('config'), 'lua', 'plugin')
local plugin_files = {}
for name, type in vim.fs.dir(plugin_dir) do
    if type == 'file' and name:match('%.lua$') then
        plugin_files[#plugin_files + 1] = name:gsub('%.lua$', '')
    end
end
table.sort(plugin_files)
for _, name in ipairs(plugin_files) do
    require('plugin.' .. name)
end

vim.cmd.colorscheme('catppuccin-mocha')

vim.cmd('packadd nvim.difftool')
vim.cmd('packadd nvim.undotree')

require('config')

vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden'
vim.opt.grepformat = '%f:%l:%c:%m'

require('vim._core.ui2').enable()
