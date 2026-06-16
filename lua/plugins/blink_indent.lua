---@module "blink.indent"
---@module "lazy"

---@type LazyPluginSpec
return {
    'saghen/blink.indent',
    event = 'BufWinEnter',
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
