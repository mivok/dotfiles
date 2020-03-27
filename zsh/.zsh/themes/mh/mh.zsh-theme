# vim:ft=zsh
# Load color formatting - this is taken care of by oh-my-zsh and is
# commented out here for now
# setopt PROMPT_SUBST
# autoload colors
# colors

# Powerline/nerdfont symbols
typeset -Ax prompt_sym=(
    pl-left-hard-divider $'\ue0b0'
    pl-left-soft-divider $'\ue0b1'
    pl-right-hard-divider $'\ue0b2'
    pl-right-soft-divider $'\ue0b3'
    python-logo $'\ue235'
)

# Dividers
prompt-left-hard-divider() {
    echo -n "%F{$LAST_BG}%K{$1}"
    LAST_BG="$1"
    echo -n "$prompt_sym[pl-left-hard-divider]"
    echo -n "%F{${2-232}}" # Default foreground to 232 (black)
}

prompt-left-hard-divider-last() {
    # Rightmost arrow - transparent/reset background
    echo -n "%k%F{$LAST_BG}"
    echo -n "$prompt_sym[pl-left-hard-divider]"
    echo -n "%f%k"
    LAST_BG=
}

prompt-left-soft-divider() {
    echo -n "$prompt_sym[pl-left-soft-divider]"
}

prompt-right-hard-divider() {
    echo -n "%F{$1}"
    echo -n "$prompt_sym[pl-right-hard-divider]"
    echo -n "%K{$1}%F{${2-232}}" # Default foreground to 232 (black)
}

prompt-right-hard-divider-first() {
    # Rightmost arrow - transparent/reset background
    echo -n "%k%F{$1}"
    echo -n "$prompt_sym[pl-right-hard-divider]"
    echo -n "%K{$1}%F{${2-232}}"
}

prompt-right-soft-divider() {
    echo -n "$prompt_sym[pl-right-soft-divider]"
}

# Set prompt color without arrows, but with setting LAST_BG
prompt-color() {
    echo -n "%F{${2-232}}%K{${1}}"
    LAST_BG="$1"
}

# Helpers

# Add entry to prompt if value is non-zero
# Usage: prompt-ifset test [value]
prompt-left-ifset() {
    if [[ -n "$1" ]]; then
        prompt-left-soft-divider
        echo -n " "
        if [[ -n "$2" ]]; then
            echo -n "$2"
        else
            echo -n "$1"
        fi
        echo -n " "
    fi
}

# Sections
prompt-retval() {
    prompt-color "%(?.12.160)" "%(?.232.254)"
    echo -n "%?"
}

prompt-userhost() {
    prompt-right-hard-divider-first '%(!.160.065)' 254
    echo -n " %n@%m "
}

prompt-time() {
    echo -n " %* "
}

prompt-git() {
    local GIT_PROMPT_INFO="$(git_prompt_info)"
    if [[ -n "$GIT_PROMPT_INFO" ]]; then
        prompt-left-soft-divider
        echo -n "$GIT_PROMPT_INFO"
    fi
}

prompt-venv() {
    prompt-left-ifset "$VIRTUAL_ENV" \
        "$prompt_sym[python-logo] ${VIRTUAL_ENV##*/}"
}

prompt-aws() {
    prompt-left-ifset "$AWS_PROFILE" \
        "$prompt_sym[aws-logo]\ue7ad $AWS_PROFILE"
}

prompt-kube() {
    # Kube config file without extension or path
    local DISPLAYKUBECONFIG="${KUBECONFIG##*/}"
    DISPLAYKUBECONFIG="${DISPLAYKUBECONFIG%.*}"
    prompt-left-ifset "$KUBECONFIG" "\ufd31 $DISPLAYKUBECONFIG"
}

prompt-ssh() {
    local AGENTFORWARDED="✗"
    if [[ -n "$SSH_AUTH_SOCK" ]]; then
        AGENTFORWARDED="✔"
    fi
    prompt-left-ifset "$SSH_CLIENT" "\uf817 ${SSH_CLIENT%% *} $AGENTFORWARDED"
}

prompt-pwd() {
    echo -n "%1~ "
}

prompt-linecol() {
    echo -n " ${COLUMNS}x${LINES} "
}

# Top line of the prompt
prompt-top() {
    # Retval and userhost have dynamic colors, and so set their own
    # colors/print their own dividers
    prompt-retval
    # This sets the colors for the rest of the prompt
    prompt-left-hard-divider 239 255
    prompt-time # This doesn't set any colors nor print any divider of its own

    # Optional sections - these should add a soft divider before them if
    # needed, and not set their own colors
    prompt-git
    prompt-venv
    prompt-aws
    prompt-kube
    prompt-ssh

    # Final arrow
    prompt-left-hard-divider-last
}

# Bottom line of the prompt
prompt-bottom() {
    prompt-pwd
    prompt-left-soft-divider
    echo -n "%f%k "
}

# Right prompt
prompt-right() {
    prompt-userhost # This sets the first hard divider
    prompt-right-hard-divider 239 255
    prompt-linecol
}

# Main prompt: top + bottom
prompt-main() {
    prompt-top
    echo
    prompt-bottom
}

PROMPT='$(prompt-main)'
RPROMPT='$(prompt-right)'
ZLE_RPROMPT_INDENT=0

ZSH_THEME_GIT_PROMPT_PREFIX=" \ue0a0 "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"

# Disable default virtualenv prompt
VIRTUAL_ENV_DISABLE_PROMPT=1
