vim.filetype.add({
    extension = {
        rasi = 'rasi',
        rofi = 'rasi',
        wofi = 'rasi',
        mdx = 'markdown.mdx',
        mdc = 'markdown',
    },

    filename = {
        ['docker-compose.yml'] = 'yaml.docker-compose',
        ['docker-compose.yaml'] = 'yaml.docker-compose',
        ['compose.yml'] = 'yaml.docker-compose',
        ['compose.yaml'] = 'yaml.docker-compose',
        ['.env'] = 'dotenv',
        ['vifmrc'] = 'vim',
    },

    pattern = {
        ['.*%.gitconfig'] = 'gitconfig',
        ['compose%..*%.ya?ml'] = 'yaml.docker-compose',
        ['docker%-compose%..*%.ya?ml'] = 'yaml.docker-compose',
        ['.*%.twig'] = 'twig.html',
        ['.*/waybar/config'] = 'jsonc',
        ['.*/mako/config'] = 'dosini',
        ['.*/kitty/.*%.conf'] = 'bash',
        ['.*/hypr/.*%.conf'] = 'hyprlang',
        ['%.env%.[%w_.-]+'] = 'dotenv',
        ['.*%.log'] = 'log',
        ['.*%.conf'] = { 'conf', { priority = -1 } },
    },
})
