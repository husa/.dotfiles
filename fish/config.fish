if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

zoxide init fish | source

fzf --fish | source

# set default editor
set -x EDITOR nvim


# configure neovide(not worth creating a config file)
set -x NEOVIDE_FRAME transparent
set -x NEOVIDE_TITLE_HIDDEN transparent
set -x NEOVIDE_FORK 1

# add fzf defaults
set -x FZF_DEFAULT_COMMAND fd --type file --color=always
set -x FZF_DEFAULT_OPTS "--ansi --border --highlight-line --layout=reverse --preview-window 'right:50%' --preview='bat --color=always --style=grid,numbers --wrap=character {}'"
set -x FZF_CTRL_R_OPTS "--preview='echo {}' --preview-window=hidden"
