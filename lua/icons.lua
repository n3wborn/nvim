local M = {}

--- Diagnostic severities.
M.diagnostics = {
    ERROR = '',
    WARN = '',
    HINT = '',
    INFO = '',
}

--- For folding.
M.arrows = {
    right = '',
    left = '',
    up = '',
    down = '',
}

--- LSP symbol kinds.
M.symbol_kinds = {
    Array = ' 󰅪 ',
    Boolean = ' ◩ ',
    Class = ' 󰠱 ',
    Color = '  ',
    Constant = ' 󰏿 ',
    Constructor = '  ',
    Copilot = '  ',
    Enum = ' 󰕘 ',
    EnumMember = ' 󰕘 ',
    Event = '  ',
    Field = '  ',
    File = '  ',
    Folder = '  ',
    Function = ' 󰊕 ',
    Interface = ' 󰕘 ',
    Key = ' 󰌋 ',
    Keyword = '  ',
    Method = '  ',
    Module = '  ',
    Namespace = '  ',
    Null = ' 󰟢 ',
    Number = ' 󰎠 ',
    Object = ' 󰅩 ',
    Operator = ' 󰆕 ',
    Package = '  ',
    Property = '  ',
    Reference = '  ',
    Snippet = '  ',
    String = ' 󰀬 ',
    Struct = ' 󰙅 ',
    Text = '  ',
    TypeParameter = ' 󰊄 ',
    Unit = '  ',
    Value = '  ',
    Variable = '󰆧 ',
}

--- Git symbols
M.git = {
    git = ' ',
    added = ' ',
    modified = ' ',
    removed = ' ',
}

--- Spinner
M.spinner = {
    dot = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
    arc = { '◜', '◠', '◝', '◞', '◡', '◟' },
    circle = { '◐', '◓', '◑', '◒', '◐', '◓', '◑', '◒' },
    quarter = { '◴', '◷', '◶', '◵' },
}

--- Todolist
M.todolist = {
    todo = '  ',
    wip = ' 󰦕 ',
    done = '  ',
}

--- Shared icons that don't really fit into a category.
M.misc = {
    bug = '',
    dashed_bar = '┊',
    ellipsis = '…',
    git = '',
    palette = '󰏘',
    robot = '󰚩',
    search = '',
    terminal = '',
    toolbox = '󰦬',
    vertical_bar = '│',
}

return M
