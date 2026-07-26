---@module "blink.indent"
---@module "lazy"

---@type LazySpec
return {
    'saghen/blink.indent',
    event = 'BufRead',
    --- @type blink.indent.Config
    opts = {
        blocked = { buftypes = { include_defaults = true }, filetypes = { include_defaults = true } },
        scope = {
            char = '▏',
            enabled = true,
            indent_at_cursor = false,
            priority = 1000,
            underline = { enabled = true },
        },
        static = {
            char = '▏',
            enabled = true,
        },
    },
}
