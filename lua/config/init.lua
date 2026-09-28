require('config.options')
require('config.keymaps')
require('config.autocommands')
require('config.winbar')
require('config.lsp').setup()
require('config.folding')

if vim.g.sessions_enabled then
    require('config.sessions').start()
end
