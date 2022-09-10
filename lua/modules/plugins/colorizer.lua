local colorizer_ok, colorizer = pcall(require, 'colorizer')

if not colorizer_ok then
    print('Something went wrong with', colorizer)
    return
else
    colorizer.setup({
        'css',
        'scss',
        'html',
        'javascript',
    })
end
