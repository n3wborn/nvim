return {
    src = 'https://github.com/b0o/SchemaStore.nvim',
    data = {
        setup = function()
            require('schemastore').load()
        end,
    },
}
