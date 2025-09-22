if status is-interactive
    # Commands to run in interactive sessions can go here
end

# VIM mode
set -g fish_key_bindings fish_vi_key_bindings
# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line blink
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
set fish_cursor_external line
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block
# Force change it for Wezterm
set fish_vi_force_cursor 1
# set fish color scheme
fish_config theme choose "fish default"

# remove greeting
set -U fish_greeting

if command -q kubectl
  kubectl completion fish | source
end
if command -q docker
  docker completion fish | source
end

if command -q starship
  starship init fish | source
end

if command -q fzf
  fzf --fish | source
end
if command -q zoxide
  zoxide init fish | source
end

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

# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# if file ./local.fish exists, source it
if test -f $HOME/.config/fish/local.fish
  source $HOME/.config/fish/local.fish
end

