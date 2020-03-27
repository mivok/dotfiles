# ~/.zshrc

# Path
path=("$HOME/bin" $path "$HOME/go/bin" "$HOME/.local/bin")

# Set up antigen
source ~/.zsh/antigen.zsh

antigen use oh-my-zsh

# Load plugins
antigen bundle autojump
antigen bundle aws
antigen bundle direnv
antigen bundle docker
antigen bundle fzf

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Local plugins/configuration
antigen bundle ~/.zsh/local_plugins/colors
antigen bundle ~/.zsh/local_plugins/appsettings
antigen bundle ~/.zsh/local_plugins/aliases
antigen bundle ~/.zsh/local_plugins/functions

# Theme
antigen theme ~/.zsh/themes/mh

antigen apply
