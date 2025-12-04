return {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = true,
    ft = { 'markdown' },
    event = 'VeryLazy',
    opts = {
        bullet = {
            enabled = true,
        },
        checkbox = {
            enabled = true,
            position = 'inline',
        },
        html = {
            enabled = true,
            comment = {
                conceal = true,
            },
        },
    },
}
