local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').tailwindcss.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { 'tailwindcss-language-server', '--stdio' },
            settings = {
                tailwindCSS = {
                    validate = true,
                    lint = {
                        cssConflict = 'warning',
                        invalidApply = 'error',
                        invalidScreen = 'error',
                        invalidVariant = 'error',
                        invalidConfigPath = 'error',
                        invalidTailwindDirective = 'error',
                        recommendedVariantOrder = 'warning',
                    },
                    classAttributes = {
                        'class',
                        'className',
                        'class:list',
                        'classList',
                        'ngClass',
                    },
                },
                root_dir = function(fname)
                    local util = require('lspconfig.util')
                    return util.root_pattern(
                        'tailwind.config.js',
                        'tailwind.config.cjs',
                        'tailwind.config.mjs',
                        'tailwind.config.ts',
                        'postcss.config.js',
                        'postcss.config.cjs',
                        'postcss.config.mjs',
                        'postcss.config.ts'
                    )(fname) or util.find_package_json_ancestor(fname) or util.find_node_modules_ancestor(
                        fname
                    ) or util.find_git_ancestor(fname)
                end,
            },
        })
    end,
}

return M
