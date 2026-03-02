return {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && npm install',
    init = function()
        vim.g.mkdp_filetypes = { 'markdown' }
    end,
    cond = function()
        return vim.g.markdown_preview_enabled and not vim.g.live_previewer_enabled
    end,
    ft = { 'markdown' },
}
