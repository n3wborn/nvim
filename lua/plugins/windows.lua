return {
    'anuvyklack/windows.nvim',
    config = true,
    dependencies = {
        'anuvyklack/middleclass',
        'anuvyklack/animation.nvim',
    },
    keys = {
        { '<C-w>z', '<cmd>WindowsMaximize<cr>', desc = 'Maximize Windows' },
        { '<C-w>_', '<cmd>WindowsMaximizeVertically<cr>', desc = 'Maximize Vertically' },
        { '<C-w>|', '<cmd>WindowsMaximizeHorizontally<cr>', desc = 'Maximize Horizontaly' },
        { '<C-w>=', '<cmd>WindowsEqualize<cr>', desc = 'Equalize Windows' },
    },
}
