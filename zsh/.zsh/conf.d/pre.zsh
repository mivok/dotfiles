# pre.zsh
# Miscellaneous application settings that need to be set before plugins are loaded

# Fzf via homebrew
if [[ -e /opt/homebrew/opt/fzf ]]; then
    export FZF_BASE=/opt/homebrew/opt/fzf
fi
