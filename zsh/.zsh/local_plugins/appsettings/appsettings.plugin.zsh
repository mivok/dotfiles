# appsettings.plugin.zsh
# Miscellaneous application settings

# Homebrew
export HOMEBREW_AUTO_UPDATE_SECS=86400
# export HOMEBREW_NO_GITHUB_API=1
# export HOMEBREW_NO_AUTO_UPDATE=1

# MPD server
export MPD_HOST=officenoise.local

# AWS settings
export AWS_SDK_LOAD_CONFIG=1

# Default editor
# Lower down in the list is preferred editor
[[ -x "/usr/bin/vi" ]] && export EDITOR=/usr/bin/vi
[[ -x "/usr/bin/vim" ]] && export EDITOR=/usr/bin/vim
[[ -x "/usr/local/bin/vim" ]] && export EDITOR=/usr/local/bin/vim
[[ -x "/usr/local/bin/nvim" ]] && export EDITOR=/usr/local/bin/nvim

# Go
export GOPATH=$HOME/go

# Autoload github token
if [[ -f ~/.githubtoken ]]; then
    GITHUB_TOKEN=$(cat ~/.githubtoken)
    export GITHUB_TOKEN
fi

# ZSH autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"

