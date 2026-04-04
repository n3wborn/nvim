vim.filetype.add({
    pattern = {
        ['%.env%.[%w_.-]+'] = 'dotenv',
    },
})
