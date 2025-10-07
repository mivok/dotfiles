# appsettings.plugin.zsh
# Miscellaneous application settings

# Homebrew
export HOMEBREW_AUTO_UPDATE_SECS=86400
# export HOMEBREW_NO_GITHUB_API=1
# export HOMEBREW_NO_AUTO_UPDATE=1

# AWS settings (fixes terraform and others)
export AWS_SDK_LOAD_CONFIG=1

# Default editor
EDITOR="$(whence -p nvim || whence -p vim || whence -p vi)"
export EDITOR

# Go
export GOPATH=$HOME/go

# ZSH autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"
# Make pasting fast with ZSH autosuggestions
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# Disable highlighting on paste (which confuses the heck out of me because
# it looks like the text is selected and that it's going to overwrite what I
# pasted)
typeset -a zle_highlight
zle_highlight+=(paste:none)

# History behavior
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
# This shouldn't be set if SHARE_HISTORY is set
unsetopt INC_APPEND_HISTORY

# Use ripgrep config file
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rc"
