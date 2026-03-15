vim.schedule(function()
    vim.pack.add({ 'https://github.com/b0o/SchemaStore.nvim' })

    require('schemastore').load()
end)
