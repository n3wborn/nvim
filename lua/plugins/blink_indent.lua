---@module "blink.indent"
---@module "lazy"

---@type LazySpec
return {
    'saghen/blink.indent',
    event = 'BufRead',
    --- @type blink.indent.Config
    opts = {
        scope = {
            char = '▏',
            enabled = true,
        },
        static = {
            char = '▏',
            enabled = true,
        },
    },
}
