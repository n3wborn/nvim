---@module "blink.indent"
---@module "lazy"

---@type LazySpec
return {
    'saghen/blink.indent',
    event = 'BufRead',
    opts = function()
        --- @type blink.indent.Config
        return {
            scope = {
                char = '▏',
                enabled = true,
            },
            static = {
                char = '▏',
                enabled = true,
            },
        }
    end,
}
