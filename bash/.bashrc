# ~/.bashrc
# vim:fdm=marker

# Ignore following sourced files
# shellcheck disable=SC1090 disable=SC1091

# Non interactive entries
# Path {{{
CHEFDK_RUBY_BINS=$(printf "%s:" "$HOME"/.chefdk/gem/ruby/*/bin)

export PATH="/usr/local/bin:/usr/local/sbin:\
$CHEFDK_RUBY_BINS\
/bin:/usr/bin:/sbin:/usr/sbin:\
$HOME/go/bin"

# Do Manpath too, so path_helper will set manpath
export MANPATH=

# Path helper adds paths in /etc/paths.d and /etc/manpaths.d to the path
if [[ -x /usr/libexec/path_helper ]]; then
    eval "$(/usr/libexec/path_helper -s)"
fi

# A few directories we want first in the path, add them here
export PATH="$HOME/bin:\
/opt/chef-workstation/bin:/opt/chef-workstation/embedded/bin:\
$PATH"
# }}}

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# Interactive stuff here
# OS specific stuff {{{

UNAME=$(uname)
[[ $UNAME == 'FreeBSD' ]] && {
    # Use a custom tput that actually works (requires ncurses package)
    [[ -x /usr/local/bin/tput ]] && TPUT=/usr/local/bin/tput
}
[[ $UNAME == 'OpenBSD' ]] && {
    # Set terminal to a color variant of xterm
    [[ $TERM == "xterm" ]] && export TERM=xterm-color
}
[[ $UNAME == 'SunOS' ]] && {
    # Set terminal to a color variant of xterm
    [[ $TERM == "xterm" ]] && export TERM=xtermc
}

#}}}
# Bash options {{{

# Don't save duplicate history entries, nor anything beginning with a space
export HISTCONTROL=ignoreboth
# Giant history
export HISTSIZE=10000
# Dynamically update LINES and COLUMNS
shopt -s checkwinsize
# Append to history file
shopt -s histappend

#}}}
# Color stuff {{{
# Color variables {{{

[[ -z $TPUT ]] && TPUT="tput"
RESET="$(     $TPUT sgr0)"    # Reset all attributes
BRIGHT="$(    $TPUT bold)"    # Set “bright” attribute
BLACK="$(     $TPUT setaf 0)" # foreground to color #0 - black
RED="$(       $TPUT setaf 1)" # foreground to color #1 - red
GREEN="$(     $TPUT setaf 2)" # foreground to color #2 - green
YELLOW="$(    $TPUT setaf 3)" # foreground to color #3 - yellow
BLUE="$(      $TPUT setaf 4)" # foreground to color #4 - blue
MAGENTA="$(   $TPUT setaf 5)" # foreground to color #5 - magenta
CYAN="$(      $TPUT setaf 6)" # foreground to color #6 - cyan
WHITE="$(     $TPUT setaf 7)" # foreground to color #7 - white
FGDEFAULT="$( $TPUT setaf 9)" # default foreground color
export RESET BRIGHT BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE FGDEFAULT

# }}}
# Enable color ls {{{

if [[ "$TERM" != "dumb" ]]; then
    if [[ -x $(which dircolors) ]]; then
        eval "$(dircolors -b)"
    fi
    # If we are running gnu ls, turn on color. Otherwise, use -F for file type
    if ls --color=auto /dev/null >/dev/null 2>&1; then
        alias ls='ls --color=auto'
    else
        alias ls='ls -F'
    fi
fi

# }}}
# Color man pages {{{

export LESS_TERMCAP_mb=$BRIGHT$RED        # begin blinking
export LESS_TERMCAP_md=$BRIGHT$BLUE       # begin bold
export LESS_TERMCAP_me=$RESET             # end mode
export LESS_TERMCAP_se=$RESET             # end standout-mode
export LESS_TERMCAP_so=$CYAN              # begin standout-mode - info box
export LESS_TERMCAP_ue=$RESET             # end underline
export LESS_TERMCAP_us=$UNDERLINE$CYAN    # begin underline

# }}}
# Color less {{{
export LESS="-R"
export LESSQUIET=1
# }}}
# }}}
# Bash completion {{{
# This makes bash-completion 2 work with existing homebrew v1 completions
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"

if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi
if [[ -f /usr/local/etc/bash_completion ]]; then
    . /usr/local/etc/bash_completion
fi
if [[ -f /usr/local/etc/profile.d/bash_completion.sh ]]; then
    . /usr/local/etc/profile.d/bash_completion.sh
fi

# }}}
# Prompt {{{
function setprompt {
    # Set color based on whether we are ssh or local
    if [[ -z $SSH_CLIENT ]]; then
        # Local
        local PCOLOR=$BRIGHT$CYAN
    else
        # Remote/SSH
        local PCOLOR=$BRIGHT$GREEN
    fi

    # Set color based on username
    case "$USER" in
    root)
        local UCOLOR=$BRIGHT$RED
        ;;
    *)
        local UCOLOR=$BRIGHT$GREEN
        ;;
    esac

    # SSH client
    local SSHPROMPT=${SSH_CLIENT%% *}
    if [[ -n $SSHPROMPT ]]; then
        SSHPROMPT=" $SSHPROMPT"
        # Show if ssh agent is forwarded
        if [[ -n $SSH_AUTH_SOCK ]]; then
            SSHPROMPT="$SSHPROMPT*"
        fi
    fi

    PS1="\$PROMPT_PREFIX\\[$UCOLOR\\]\\u@\\h$RESET \\[$PCOLOR\\]\\t$RESET"
    PS1="$PS1 \$RETVAL_PROMPT\$EXTRA_PROMPT$SSHPROMPT\\n\\W ➤ "
}

prompt_command() {
    # Command status
    RETVAL_PROMPT=$?
    if [[ $RETVAL_PROMPT != 0 ]]; then
        RETVAL_PROMPT=$BRIGHT$RED$RETVAL_PROMPT$RESET
    fi

    EXTRA_PROMPT=""

    # Show lines/columns if present
    if [[ -n $LINES && -n $COLUMNS ]]; then
        EXTRA_PROMPT+="${COLUMNS}x${LINES}"
    fi

    # Git prompt
    GITPROMPT=
    if declare -f __git_ps1 >/dev/null; then
        GITPROMPT=$(__git_ps1 "%s")
    fi
    [[ $GITPROMPT == "(unknown)" ]] && GITPROMPT=
    if [[ -n $GITPROMPT ]]; then
        EXTRA_PROMPT+=" git:$GITPROMPT"
    fi

    # Python virtualenv
    [[ -n $VIRTUAL_ENV ]] && EXTRA_PROMPT+=" venv:${VIRTUAL_ENV##*/}"

    # GOPATH prompt
    if [[ $GOPATH != "$DEFAULT_GOPATH" ]]; then
        GOPROMPT=$GOPATH
        # Shorten GOPATH where sensible
        GOPROMPT=${GOPROMPT/:*/}
        GOPROMPT=${GOPROMPT/$HOME/}
        GOPROMPT=${GOPROMPT/\/git\/*\//}
        EXTRA_PROMPT+=" go:$GOPROMPT"
    fi

    # Chef profile
    if [[ -n $CHEF_PROFILE ]]; then
        EXTRA_PROMPT+=" chef:${CHEF_PROFILE}"
    fi

    # AWS profile
    if [[ -n $AWS_PROFILE ]]; then
        EXTRA_PROMPT+=" aws:${AWS_PROFILE}"
    fi

    # Kubernetes config file
    if [[ -n $KUBECONFIG ]]; then
        EXTRA_PROMPT+=" kube:${KUBECONFIG##*/}"
    fi

    # Jira project
    if [[ -n $JIRA_PROJECT ]]; then
        EXTRA_PROMPT+=" jira:${JIRA_PROJECT}"
    fi

    # Prompt prefix
    if [[ -n $STY || -n $TMUX ]]; then
        # Screen/tmux
        PROMPT_PREFIX="⎚ "
    elif [[ -n $SSH_CLIENT ]]; then
        # SSH
        PROMPT_PREFIX="☁︎ "
    else
        # Normal
        PROMPT_PREFIX="⌂ "
    fi

    # Set xterm title if in an xterm
    case "$TERM" in
    xterm*|rxvt*|screen*)
        echo -ne "\\033]0;${HOSTNAME/.*/} [$EXTRA_PROMPT]\\007"
        ;;
    esac

    if [[ -n $PROMPT_TITLE_ONLY ]]; then
        EXTRA_PROMPT=""
    fi
}
PROMPT_COMMAND=prompt_command
PROMPT_TITLE_ONLY=1
setprompt

# }}}
# Aliases {{{

# Short dig alias
alias sdig='dig +short'

# mDNS dig
alias mdig='dig @224.0.0.251 -p 5353 +time=1 +tries=1'

# Perl timestamp alias
# shellcheck disable=SC2142
alias perlts='perl -p -e "s/^(\d+)/localtime(\$1)/e"'

# List running vms
# shellcheck disable=SC2142
alias runningvms="VBoxManage list runningvms | awk -F'\"' '{print \$2}'"
alias runningcontainers="docker ps --format '{{.Image}}\\t{{.Names}}'"

# Make homebrew not use the full path (e.g. chefdk)
alias brew='PATH="/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/sbin:/usr/sbin" brew'

# Use nvim if available
if command -v nvim > /dev/null; then
    alias vim=nvim
fi

# Use hub command if available
if command -v hub > /dev/null; then
    alias git=hub
fi

# For when you recreate a machine and try to ssh to it
# shellcheck disable=SC2142
alias fussh='ssh-keygen -R $(ssh -G $(history -p '\''!!:$'\'' | sed "s/.*@//") | awk '\''$1 == "hostname" { print $2 }'\'')'

function chefprofile() {
    # Usage: chefprofile PROFILENAME
    export CHEF_PROFILE="$1"
    echo "CHEF_PROFILE=$CHEF_PROFILE"
}
complete -W "$(awk '/^\[/ { print substr($0, 2, length($0) - 2) }' \
    ~/.chef/credentials)" chefprofile

function awsprofile() {
    # Usage: awsprofile PROFILENAME
    export AWS_PROFILE="$1"
    echo "AWS_PROFILE=$AWS_PROFILE"
}
complete -W "$(awk '/^\[/ { print substr($0, 2, length($0) - 2) }' \
    ~/.aws/credentials)" awsprofile

function kcfg() {
    # Usage: kcfg CONFIGFILENAME
    export KUBECONFIG="$HOME/.kube/$1"
    echo "KUBECONFIG=$KUBECONFIG"
}
complete -W "$(cd "$HOME/.kube" && ls -- *.config 2>/dev/null)" kcfg

function kns() {
    export KUBECTL_NAMESPACE="$1"
    echo "KUBECTL_NAMESPACE=$KUBECTL_NAMESPACE"
}

# Fixes filenames downloaded with curl/wget that still have query strings on
# the end
function stripquerystring() {
    mv "$1" "${1/\?*/}"
}

# Change prompt to '$ ' for use when copy/pasting or in demos
alias demoprompt='OLDPS1="$PS1"; PS1="\$ "'
alias restoreprompt='PS1="$OLDPS1"'

# Jira project settings
function jirap() {
    if [[ -z "$1" ]]; then
        echo "Usage: jirap PROJECT"
        echo "Sets the current jira project"
        return 1
    fi
    JIRA_PROJECT="$1"
    export JIRA_PROJECT
}

# Set kubernetes namespace with environment variable
kubectl() {
    local ARGS=()
    if [[ -n $KUBECTL_NAMESPACE ]]; then
        ARGS+=(--namespace "$KUBECTL_NAMESPACE")
    fi
    if [[ -n $KUBECTL_CONTEXT ]]; then
        ARGS+=(--context "$KUBECTL_CONTEXT")
    fi
    command kubectl "${ARGS[@]}" "$@"
}

# Alias to switch between stage/prod directories
cde() {
    if [[ $PWD =~ /(stage|staging)/ ]]; then
        # shellcheck disable=SC2086
        cd ${PWD/\/stag*\//\/prod*\/} || return
        pwd
    elif [[ $PWD =~ /(prod)/ ]]; then
        # shellcheck disable=SC2086
        cd ${PWD/\/prod*\//\/stag*\/} || return
        pwd
    else
        echo "Skipping cd: Outside of a stage/prod directory"
    fi
}

#}}}
# Direnv setup {{{
if which direnv >/dev/null 2>&1; then
    # We need to manually do the direnv hook here because prompt_command
    # (which reads $? for the return value of the previous command) needs to
    # come first in order to get a reliable return value.
    _direnv_hook() {
      eval "$(direnv export bash)";
    };
    if ! [[ "$PROMPT_COMMAND" =~ _direnv_hook ]]; then
      PROMPT_COMMAND="$PROMPT_COMMAND; _direnv_hook"
    fi
fi
# }}}
# Helper scripts (lesspipe, autojump) {{{

# Make less work with non-text files better
# brew install lesspipe
if type -P lesspipe.sh > /dev/null; then
    eval "$(lesspipe.sh)"
fi
if type -P lesspipe > /dev/null; then
    eval "$(lesspipe)"
fi

# Autojump (brew install autojump)
# Note: this should appear after PROMPT_COMMAND= because it modifies
# PROMPT_COMMAND
export AUTOJUMP_KEEP_SYMLINKS=1
[[ -s /usr/local/etc/autojump.sh ]] && . /usr/local/etc/autojump.sh
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

# Fzf - fuzzy finder
FZF_PATH="/usr/local/opt/fzf" # Homebrew install location for fzf
if [[ -d "$FZF_PATH" ]]; then
    source "$FZF_PATH/shell/completion.bash"
    source "$FZF_PATH/shell/key-bindings.bash"
fi

# Fzf/autojump integration (j without args uses fzf)
function j() {
    if [[ "$#" -ne 0 ]]; then
        # shellcheck disable=SC2164
        cd "$(autojump "$@")"
        pwd
        return
    fi
    # shellcheck disable=SC2164
    cd "$(autojump -s | sort -k1gr |
        awk '$1 ~ /[0-9]:/ && $2 ~ /^\// {
            for (i=2; i<=NF; i++) { print $(i) }
        }' |
        fzf --height 40% --reverse --inline-info)"
    pwd
}
# }}}
# Default editor {{{
# Lower down in the list is preferred editor
[[ -x "/usr/bin/vi" ]] && export EDITOR=/usr/bin/vi
[[ -x "/usr/bin/vim" ]] && export EDITOR=/usr/bin/vim
[[ -x "/usr/local/bin/vim" ]] && export EDITOR=/usr/local/bin/vim
[[ -x "/usr/local/bin/nvim" ]] && export EDITOR=/usr/local/bin/nvim
# }}}
# Go {{{
export GOPATH=$HOME/go
export DEFAULT_GOPATH="$GOPATH" # Used in bash prompt
# }}}
# Habitat {{{
if [[ -e $HOME/.hab-token ]]; then
    HAB_AUTH_TOKEN="$(cat "$HOME"/.hab-token)"
    export HAB_AUTH_TOKEN
fi
# }}}
# Github {{{
if [[ -f ~/.githubtoken ]]; then
    GITHUB_TOKEN=$(cat ~/.githubtoken)
    export GITHUB_TOKEN
fi
# }}}
# Homebrew {{{
export HOMEBREW_AUTO_UPDATE_SECS=86400
# HOMEBREW_NO_GITHUB_API=1
# HOMEBREW_NO_AUTO_UPDATE=1
# }}}
# aws-vault {{{
export AWS_ASSUME_ROLE_TTL="1h"
# Use the login keychain for storage
export AWS_VAULT_KEYCHAIN_NAME="login"
# }}}
# MPD server {{{
export MPD_HOST=officenoise.local
# }}}
