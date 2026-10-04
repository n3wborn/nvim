vim.opt_local.wrap = true
vim.opt_local.breakindent = true
vim.opt_local.linebreak = true
vim.opt_local.conceallevel = 0

-- insert an image link, path relative to the buffer and url-encoded for snacks.image
local function encode(path)
    return (path:gsub('[%%%s+()<>]', function(c)
        return string.format('%%%02X', c:byte())
    end))
end

vim.keymap.set('n', '<leader>mi', function()
    local bufdir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    Snacks.picker.files({
        cwd = bufdir,
        hidden = true,
        ft = { 'png', 'jpg', 'jpeg', 'gif', 'webp', 'svg', 'avif' },
        confirm = function(picker, item)
            picker:close()
            if not item then
                return
            end
            local abs = vim.fs.normalize(Snacks.picker.util.path(item))
            local path = vim.fs.relpath(bufdir, abs) or abs
            local alt = vim.fn.fnamemodify(abs, ':t:r'):gsub('[-_]', ' ')
            vim.api.nvim_put({ ('![%s](%s)'):format(alt, encode(path)) }, 'c', true, true)
        end,
    })
end, { buffer = true, desc = 'Insert image link' })
