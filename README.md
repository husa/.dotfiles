# .dotfiles

## Quick start

### 1. Clone repo into your `$HOME` dir

```sh
git clone git@github.com:husa/.dotfiles.git ~/.dotfiles
```

### 2. Install stuff

```sh
brew bundle install
```

### 3. Link stuff

```sh
ln -sv (pwd)/git $HOME/.config/git
ln -sv (pwd)/fish $HOME/.config/fish
ln -sv (pwd)/starship/starship.toml $HOME/.config/starship.toml
ln -sv (pwd)/yazi $HOME/.config/yazi
ln -sv (pwd)/nvim $HOME/.config/nvim
# ln -sv (pwd)/nvim-lazyvim $HOME/.config/nvim-lazyvim
ln -sv (pwd)/wezterm $HOME/.config/wezterm
ln -sv (pwd)/hammerspoon $HOME/.config/hammerspoon
ln -sv (pwd)/gitui $HOME/.config/gitui
```

change default hammerspoon config location

```sh
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
```

### 4. Install other stuff

- `yazi` flavors and plugins
- `delta` themes

```sh
ya pack -i
curl https://raw.githubusercontent.com/dandavison/delta/main/themes.gitconfig > git/delta.themes.gitconfig
```

# General

- ~~[iterm2](https://iterm2.com/) - terminal emulator~~
- [wewzterm](https://wezfurlong.org/wezterm/index.html) - terminal emulator
- [homebrew](https://brew.sh/) - package manager
- [fish](https://fishshell.com/) - shell
- [starship](https://starship.rs/) - prompt
- [hammerspoon](https://www.hammerspoon.org/) - macos automation tool
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) - fonts with added glyphs, used - `font-fira-code-nerd-font`

# Tools

- [zoxide](https://github.com/ajeetdsouza/zoxide) - better `cd`
- [eza](https://github.com/ajeetdsouza/zoxide) - better `ls`, fork of `exa`
- [bat](https://github.com/sharkdp/bat) - better `cat`
- [fzf](https://github.com/junegunn/fzf) - fuzzy search
- [yazi](https://github.com/sxyazi/yazi) - file manager
- [ripgrep](https://github.com/BurntSushi/ripgrep) - better `grep`
- [fd](https://github.com/sharkdp/fd) - better `find`
- [jq](https://github.com/jqlang/jq) - JSON traversal
- [jnv](https://github.com/ynqa/jnv) - interactive `jq`
- [neovim](https://neovim.io/) - text editor
- [gitui](https://github.com/gitui-org/gitui) - `git` TUI
