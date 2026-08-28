require('config.options')
require('config.keymaps')
require('config.autocommands')
require('config.winbar')
require('config.lsp').setup()
require('config.folding')
require('config.textobjects_keymaps').setup()

if vim.g.sessions_enabled then
    require('config.sessions').start()
end
