local null_ls = require('null-ls')
local b = null_ls.builtins

local sources = {
    b.formatting.prettierd.with({
        filetypes = { 'html', 'json', 'yaml' },
    }),
    b.formatting.stylua.with({
        condition = function(utils)
            return utils.root_has_file('stylua.toml')
        end,
    }),
    b.formatting.trim_whitespace.with({ filetypes = { 'tmux', 'zsh' } }),
    b.formatting.shfmt,
    b.diagnostics.write_good,
    b.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
    b.code_actions.gitsigns,
}

local M = {}
M.setup = function(on_attach)
    null_ls.config({
        -- debug = true,
        sources = sources,
    })
    require('lspconfig')['null-ls'].setup({ on_attach = on_attach })
end

return M
