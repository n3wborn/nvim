# Nvim

I use this repo to keep track of my own neovim config. Use it if you want but keep this in mind :

-   It's made for **neovim nightly**
-   There's **no install script** so you would have to make it by yourself.
-   I still not use pcall() for every required files/plugins so **if something required is missing the config can be broken**.
-   There's **only some manually installed lsp servers** (I find lsp installers useless).
-   The **file hierarchy is opiniated** and not the best thing to lazy load plugins with packer.
-   I don't do this often but sometime I `git push --force` which can result in a broken git history on your side.

[Jose Elias Alvarez](https://github.com/jose-elias-alvarez)'s job around neovim is awesome and I really love the work he does on null-ls.
Some parts of my config his taken from his [dotfiles repo](https://github.com/jose-elias-alvarez/dotfiles/tree/main/config/nvim).
You should look at it !

If you're looking for an easy-to-use and better neovim experience with good default config, these projects may fit your needs :

-   [Lunarvim](https://github.com/LunarVim/LunarVim)
-   [Astrovim](https://github.com/AstroNvim/AstroNvim)

I'm sure there's more projects like these but it's the only one I know for neovim.
