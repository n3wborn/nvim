-- autocommands
local exec = vim.api.nvim_exec
local TrimWhitespace = exec(
    [[
    function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
    endfunction

    call TrimWhitespace()
    ]],
true)

-- Taken from https://github.com/ibhagwan/nvim-lua/blob/main/lua/autocmd.lua
local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

local autocmds = {
    set_formatoptions = {
        { "BufEnter", "*", "setlocal formatoptions-=o" };
    };
    terminal_job = {
        { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber" };
    };
    resize_windows_proportionally = {
        { "VimResized", "*", [[tabdo wincmd =]]};
    };
    toggle_search_highlighting = {
        { "InsertEnter", "*", ":nohlsearch | redraw" };
    };
    wins = {
        -- Highlight current line only on focused window
        {"WinEnter,BufEnter,InsertLeave", "*", [[if ! &cursorline && ! &pvw | setlocal cursorline | endif]]};
        {"WinLeave,BufLeave,InsertEnter", "*", [[if &cursorline && ! &pvw | setlocal nocursorline | endif]]};
    };
    solidity = {
        { "BufRead,BufNewFile", "*.sol", "set filetype=solidity" };
    };
    trim_white_space = {
        {"BufWritePre", "*", "call TrimWhitespace()"};
    };
    -- formatting_sync = {
    --     {"BufWritePre", "*", "lua vim.lsp.buf.formatting_sync()"};
    -- };
    git_commit = {
        {"BufNewFile, BufRead", "COMMIT_EDITMSG", "set spell nonumber wrap linebreak"};
        {"FileType", "gitcommit", "let b:EditorConfig_disable = 1"};
    };
    -- hover = {
    --     {"CursorHold", "*", "lua vim.lsp.buf.hover()"};
    -- };
}

nvim_create_augroups(autocmds)
