return {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
        filetypes = { 'javascript', 'typescript', 'html', 'css', 'scss', '!lazy', '!prompt', '!nofile' },
        buftype = { 'javascript', 'typescript', 'html', 'css', 'scss' },
    },
}
