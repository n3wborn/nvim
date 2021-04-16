-- Function to bind picker to key combination
local M = {}

function M.bind_picker(keys, picker_name, extension_name)
    if extension_name ~= nil then
        vim.api.nvim_set_keymap(
            'n', keys,
            "<cmd>lua require('telescope').extensions['" .. extension_name .. "']"
            .. "['" .. picker_name .. "']()<CR>",
            {}
        )
    else
        vim.api.nvim_set_keymap(
            'n', keys,
            "<cmd>lua require('telescope.builtin')['" .. picker_name .. "']()<CR>",
        {}
        )
    end
end

function M.buf_bind_picker(bufnr, keys, picker_name, extension_name)
    if extension_name ~= nil then
        vim.api.nvim_buf_set_keymap(
            bufnr, 'n', keys,
            "<cmd>lua require('telescope').extensions['" .. extension_name .. "']"
            .. "['" .. picker_name .. "']()<CR>",
            {}
        )
    else
        vim.api.nvim_buf_set_keymap(
            bufnr, 'n', keys,
            "<cmd>lua require('telescope.builtin')['" .. picker_name .. "']()<CR>",
        {}
        )
    end
end

return M
