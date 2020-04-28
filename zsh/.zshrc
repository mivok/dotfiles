# ~/.zshrc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
antigen bundle zsh-users/zsh-completions

# Local plugins/configuration
antigen bundle ~/.zsh/local_plugins/colors
antigen bundle ~/.zsh/local_plugins/appsettings
antigen bundle ~/.zsh/local_plugins/aliases
antigen bundle ~/.zsh/local_plugins/functions
antigen bundle ~/.zsh/local_plugins/kubectl

# Theme
# antigen theme ~/.zsh/themes/mh
antigen theme romkatv/powerlevel10k

antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
