#!/bin/bash

lua_ls_dir="${HOME}/prog/git/"

echo "[neovim requirements] -- install"
sudo dnf -y install ninja-build cmake gcc make unzip gettext curl

echo "[gh cli] -- install"
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh

echo "[lua-language-server] -- install"
mkdir -p "${lua_ls_dir}" &&
    git clone https://github.com/LuaLS/lua-language-server &&
    cd "${lua_ls_dir}lua-language-server" &&
    ./make.sh

echo "[language servers] -- install (nodejs)"
# vscode-langservers-extracted => eslint, html, jsonls, cssls, typescript-language-server
yarn global add \
    @microsoft/compose-language-service \
    @olrtg/emmet-language-server \
    bash-language-server \
    cssmodules-language-server \
    custom-elements-languageserver \
    diagnostic-languageserver \
    dockerfile-language-server-nodejs \
    intelephense \
    typescript \
    vscode-langservers-extracted

echo "[language servers] -- install (go)"
go install golang.org/x/tools/gopls@latest

echo "[language servers] -- install (rust)"
mkdir -p ~/.local/bin
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - >~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer

echo "[tools] -- composer"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv /home/stef/composer.phar prog/bin/php-cs-fixer

echo "[tools] -- phpinsight"
composer global require nunomaduro/phpinsights
