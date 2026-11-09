# Nvim

![capture][capture-url]

I use this repo to keep track of my own neovim config.
Use it if you want but keep this in mind :

- It's made for **neovim nightly**
- There's **no install script**
- LSP servers must be installed/configured manually (I don't use [Mason](https://github.com/williamboman/mason.nvim))

## Install LSP servers

### Install using NPM / cargo / go / UV

```bash
# JS/TS (I use latest NPM LTS instaled with NVM)
npm i -g \
  bash-language-server \
  vscode-langservers-extracted \
  oxlint \
  tsrs \
  twiggy-language-server

# Rust
cargo binstall \
  emmylua_ls \
  kmp-lsp \
  phpantom_lsp

cargo binstall taplo-cli --features lsp

# Go
go install golang.org/x/tools/gopls@latest
go install github.com/mhersson/mpls@latest

# Python
# ty An extremely fast Python type checker and language server, written in Rust. (https://docs.astral.sh/ty)
uv tool install ty
```

### Install Using MISE

Dealing with languages and their package manager can be complicated.
Mise can simplify this. Once installed, it can install nearly every tools listed before.

#### Mise Installation

```bash
# Install mise
curl -fsSL https://mise.run | sh
```

#### Mise Configuration

```toml
[tools]
# Runtimes nécessaires aux backends
node = "26"
rust = "stable"
go = "latest"
cargo-binstall = "latest"

# npm
"npm:bash-language-server" = "latest"
"npm:vscode-langservers-extracted" = "latest"
"npm:oxlint" = "latest"
"npm:tsrs" = "latest"
"npm:twiggy-language-server" = "latest"

# Cargo
"cargo:emmylua_ls" = "latest"
"cargo:phpantom_lsp" = "latest"
"cargo:taplo-cli[features=lsp]" = "latest"

# Aqua (a `cargo binstall` like)
"aqua:Hessesian/kmp-lsp" = "latest"
"aqua:LuaLS/lua-language-server" = "latest"
"aqua:artempyanykh/marksman" = "latest"
ty = "latest"
zls = "latest"

# Go
"go:golang.org/x/tools/gopls" = "latest"
"go:github.com/mhersson/mpls" = "latest"

# Tehse are the only ones not available at the moment
# Symfony       => https://github.com/symfony/language-tools/releases
# V Analyzer    => v download -RD https://raw.githubusercontent.com/vlang/v-analyzer/main/install.vsh
```

#### Install tool using MISE

`mise install` and every languages/packages listed before are installed

[capture-url]: https://github.com/user-attachments/assets/7f1b89b6-5928-42bb-aae0-d4fb65de90d6
