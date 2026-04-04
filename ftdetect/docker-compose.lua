vim.filetype.add({
    filename = {
        ['docker-compose.yml'] = 'yaml.docker-compose',
        ['docker-compose.yaml'] = 'yaml.docker-compose',
        ['compose.yml'] = 'yaml.docker-compose',
        ['compose.yaml'] = 'yaml.docker-compose',
    },
    pattern = {
        ['compose%..*%.ya?ml'] = 'yaml.docker-compose',
        ['docker%-compose%..*%.ya?ml'] = 'yaml.docker-compose',
    },
})
