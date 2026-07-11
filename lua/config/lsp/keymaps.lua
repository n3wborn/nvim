local M = {}

function M.apply(ctx, entries)
    local opts = {
        buffer = ctx.bufnr,
        silent = true,
    }

    for _, entry in ipairs(entries) do
        if not entry.capability then
            goto continue
        end

        if not ctx.client:supports_method(entry.capability) then
            goto continue
        end

        if entry.condition and not entry.condition(ctx) then
            goto continue
        end

        if entry.keymaps then
            for _, map in ipairs(entry.keymaps) do
                vim.keymap.set(
                    map.modes,
                    map.lhs,
                    map.rhs,
                    vim.tbl_extend('force', opts, {
                        desc = map.desc,
                    })
                )
            end
        end

        if entry.setup then
            entry.setup(ctx)
        end

        ::continue::
    end
end

return M
