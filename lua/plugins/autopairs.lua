return {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = function()
        local ok, npairs = pcall(require, 'nvim-autopairs')
        local cmp_npairs = require('nvim-autopairs.completion.cmp')
        local cmp_ok, cmp = pcall(require, 'cmp')

        if not ok or not cmp_ok then
            return
        end

        npairs.setup({
            enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
            ignored_next_char = '[%w%.]', -- will ignore alphanumeric and `.` symbol
            check_ts = true, -- use treesitter to check for a pair.
            ts_config = {
                lua = { 'string', 'source' }, -- it will not add pair on that treesitter node
                javascript = { 'string', 'template_string' },
                java = false, -- don't check treesitter on java
            },
            disable_filetype = { 'TelescopePrompt' },
        })

        cmp.event:on('confirm_done', cmp_npairs.on_confirm_done({ map_char = { tex = '' } }))
    end,
}
