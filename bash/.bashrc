# ~/.bashrc
# vim:fdm=marker

# Non interactive entries
# Path {{{
export PATH="$HOME/bin:\
/usr/local/bin:/usr/local/sbin:\
/opt/chefdk/bin:/opt/chefdk/embedded/bin:${HOME}/.chefdk/gem/ruby/2.1.0/bin:\
/bin:/usr/bin:/sbin:/usr/sbin:/usr/texbin:\
/usr/local/CrossPack-AVR/bin:\
$HOME/go/bin"
# }}}

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# Interactive stuff here
# OS specific stuff {{{

UNAME=`uname`
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

[[ -z $TPUT ]] && TPUT=tput
export RESET="$(     $TPUT sgr0)"    # Reset all attributes
export BRIGHT="$(    $TPUT bold)"    # Set “bright” attribute
export BLACK="$(     $TPUT setaf 0)" # foreground to color #0 - black
export RED="$(       $TPUT setaf 1)" # foreground to color #1 - red
export GREEN="$(     $TPUT setaf 2)" # foreground to color #2 - green
export YELLOW="$(    $TPUT setaf 3)" # foreground to color #3 - yellow
export BLUE="$(      $TPUT setaf 4)" # foreground to color #4 - blue
export MAGENTA="$(   $TPUT setaf 5)" # foreground to color #5 - magenta
export CYAN="$(      $TPUT setaf 6)" # foreground to color #6 - cyan
export WHITE="$(     $TPUT setaf 7)" # foreground to color #7 - white
export FGDEFAULT="$( $TPUT setaf 9)" # default foreground color

# }}}
# Enable color ls {{{

if [[ "$TERM" != "dumb" ]]; then
    if [[ -x `which dircolors` ]]; then
        eval "`dircolors -b`"
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
# }}}
# }}}
# Bash completion {{{
if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi
if [[ -f /usr/local/etc/bash_completion ]]; then
    . /usr/local/etc/bash_completion
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

    PS1="\$PROMPT_PREFIX\[$UCOLOR\]\u@\h$RESET \[$PCOLOR\]\t$RESET"
    PS1="$PS1 \$EXTRA_PROMPT$SSHPROMPT\n\W ➤ "
}

prompt_command() {
    # Command status
    RETVAL=$?
    if [[ $RETVAL != 0 ]]; then
        RETVAL=$BRIGHT$RED$RETVAL$RESET
    fi
    EXTRA_PROMPT="$RETVAL"

    # Set xterm title if in an xterm
    case "$TERM" in
    xterm*|rxvt*)
        echo -ne "\033]0;${HOSTNAME/.*/} (${USER}): ${PWD##*/}\007"
        ;;
    esac

    # Git prompt
    GITPROMPT=
    if declare -f __git_ps1 >/dev/null; then
        GITPROMPT=`__git_ps1 "%s"`
    fi
    [[ $GITPROMPT == "(unknown)" ]] && GITPROMPT=
    if [[ -n $GITPROMPT ]]; then
        EXTRA_PROMPT+=" git:$GITPROMPT"
    fi

    # Vitualenvwrapper
    # Note: add 'PS1=$_OLD_VIRTUAL_PS1' to ~/.virtualenvs/postactivate to stop
    # virtualenvwrappers normal prompt behavior
    [[ -n $VIRTUAL_ENV ]] && EXTRA_PROMPT+=" venv:${VIRTUAL_ENV##*/}"

    # GOPATH prompt
    if [[ $GOPATH != "$DEFAULT_GOPATH" ]]; then
        GOPROMPT=$GOPATH
        # Shorten GOPATH where sensible
        GOPROMPT=${GOPROMPT/$HOME/}
        GOPROMPT=${GOPROMPT/\/git\/personal\//}
        GOPROMPT=${GOPROMPT/:*/}
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
}
PROMPT_COMMAND=prompt_command
setprompt

# }}}
# Aliases {{{

# Truss alias
alias truss='truss -rall -tall -vall -wall -xall -f'

# Short dig alias
alias sdig='dig +short'

# mDNS dig
alias mdig='dig @224.0.0.251 -p 5353 +time=1 +tries=1'

# Perl timestamp alias
alias perlts='perl -p -e "s/^(\d+)/localtime(\$1)/e"'

# Useful options to sshfs
alias sshfs='sshfs -o idmap=user,workaround=rename'

# List running vms
alias runningvms="VBoxManage list runningvms | awk -F'\"' '{print \$2}'"
alias runningcontainers="docker ps --format '{{.Image}}\t{{.Names}}'"

# knife search - wtf search term gives machines that match
alias wtf="knife search node -a fqdn -a run_list -a tags"

# Make homebrew not use the full path (e.g. chefdk)
alias brew='PATH="/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/sbin:/usr/sbin" brew'

# For when you recreate a machine and try to ssh to it
alias fussh='ssh-keygen -R $(history -p !!:$)'

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

# Fixes filenames downloaded with curl/wget that still have query strings on
# the end
function stripquerystring() {
    mv "$1" "${1/\?*/}"
}
#}}}

# Change prompt to '$ ' for use when copy/pasting or in demos
alias demoprompt='OLDPS1="$PS1"; PS1="\$ "'
alias restoreprompt='PS1="$OLDPS1"'

# Todo.txt {{{
TODOTXT_PATH="$HOME/git/external/todo.txt-cli"
[[ -d $TODOTXT_PATH ]] && {
    _todoElsewhere()
    {
        local _todo_sh="$TODOTXT_PATH/todo.sh"
        _todo "$@"
    }
    alias t="$TODOTXT_PATH/todo.sh"
    alias tm="$TODOTXT_PATH/todo.sh -d $HOME/tmsa/config/config"
    export TODOTXT_DEFAULT_ACTION=ls
    . $TODOTXT_PATH/todo_completion
    complete -F _todoElsewhere t
    complete -F _todoElsewhere tm
}
# }}}
# Hosttag Functions {{{
# Set hosttag {{{
hosttag() {
    if [[ ! -f /etc/hosttag ]]; then
        echo -e "NAME=$HOSTNAME\nCLIENT=\nLOCATION=" | sudo tee /etc/hosttag
    fi
    sudo $EDITOR /etc/hosttag
}
# }}}
# Convert old-style to new-style hosttags {{{
convert_hosttag() {
    if [[ ! -f /etc/.hosttag ]]; then
        echo "No old-style hosttag found"
        return 1
    else
        local HOSTTAG=$(cat /etc/.hosttag)
        echo "Old hosttag: $HOSTTAG"
        if [[ $HOSTTAG =~ ([0-9a-zA-Z_-]+)\ +\[([0-9a-zA-Z_-]+)/([0-9a-zA-Z_-]+) ]]; then
            echo
            echo "New hosttag:"
            echo -e "NAME=${BASH_REMATCH[1]}\nCLIENT=${BASH_REMATCH[2]}\nLOCATION=${BASH_REMATCH[3]}" | \
            sudo tee /etc/hosttag && sudo rm /etc/.hosttag
        fi
    fi
}
# }}}
# Print Hosttag {{{
print_hosttag() {
    HOSTTAG=
    if [[ -f /etc/hosttag ]]; then
        while read LINE; do
            if [[ "$LINE" =~ ([A-Z_a-z0-9]+)=(.*) ]]; then
                eval HOSTTAG_${BASH_REMATCH[1]}=\'${BASH_REMATCH[2]}\'
            fi
        done < /etc/hosttag
        echo "Host Tag: $HOSTTAG_NAME [$HOSTTAG_CLIENT/$HOSTTAG_LOCATION]"
    elif [[ -f /etc/.hosttag ]]; then
        # Old style hosttag
        echo "Old style host tag: $(cat /etc/.hosttag)"
    fi
    if [[ -f /etc/globalzone ]]; then
        echo "Global zone: $(cat /etc/globalzone)"
    fi
}
# }}}
# }}}
# Per directory git emails {{{
# To set up:
# echo "email@address.com" > .gitemail
# This can be put in a parent directory (e.g. ~/git/work) to match all subdirs
__set_git_email_vars() {
    local gitemail_file=''
    p=$(pwd)
    while [[ $p != "$HOME" && $p != "/" ]]; do
        if [[ -e $p/.gitemail ]]; then
            gitemail_file="$p/.gitemail"
            break
        fi
        p=$(dirname "$p")
    done
    if [[ -e "$gitemail_file" ]]; then
        export GIT_AUTHOR_EMAIL=$(cat "$gitemail_file")
        export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
    fi
}
if which hub >/dev/null 2>&1; then
    alias git="__set_git_email_vars; hub"
else
    alias git="__set_git_email_vars; git"
fi
# }}}
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
[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"

# Virtualenvwrapper
WORKON_HOME=$HOME/.virtualenvs
VIRTUAL_ENV_DISABLE_PROMPT=1
[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && \
    . /usr/local/bin/virtualenvwrapper.sh

# Autojump (brew install autojump)
# Note: this should appear after PROMPT_COMMAND= because it modifies
# PROMPT_COMMAND
export AUTOJUMP_KEEP_SYMLINKS=1
[[ -s /usr/local/etc/autojump.sh ]] && . /usr/local/etc/autojump.sh
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

# Gvm (go version manager)
[[ -s "/Users/mark/.gvm/scripts/gvm" ]] && . "/Users/mark/.gvm/scripts/gvm"

# Fzf - fuzzy finder
FZF_PATH="/usr/local/opt/fzf" # Homebrew install location for fzf
if [[ -d "$FZF_PATH" ]]; then
    source "$FZF_PATH/shell/completion.bash"
    source "$FZF_PATH/shell/key-bindings.bash"
fi
# }}}
# Default editor {{{
# Lower down in the list is preferred editor
[[ -x "/usr/bin/vi" ]] && export EDITOR=/usr/bin/vi
[[ -x "/usr/bin/vim" ]] && export EDITOR=/usr/bin/vim
[[ -x "/usr/local/bin/vim" ]] && export EDITOR=/usr/local/bin/vim
# }}}
# Variables {{{
# opw script variables {{{
#export OPW_CREDS_DIR="$HOME/svn/work/credentials"
export OPW_GPG_OPTS="--batch"
export OPW_CLIP_CMD="pbcopy"
# }}}
# Vagrant {{{
export VAGRANT_DEFAULT_PROVIDER=virtualbox
#which vmrun &>/dev/null && export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
# }}}
# Prefix for personal git branches (used in other scripts) {{{
export GIT_BRANCH_PREFIX=mh
# }}}
# Node npm path for brew installed npm {{{
export NODE_PATH=/usr/local/lib/node_modules
# }}}
# Make ack use less as the pager by default {{{
export ACK_PAGER="less -R"
# }}}
# Go {{{
export GOPATH=$HOME/go
export DEFAULT_GOPATH="$GOPATH" # Used in bash prompt
# }}}
# Habitat {{{
if [[ -e $HOME/.hab-token ]]; then
    export HAB_AUTH_TOKEN="$(cat "$HOME"/.hab-token)"
fi
# }}}
# Github {{{
if [[ -f ~/.githubtoken ]]; then
    export GITHUB_TOKEN=$(cat ~/.githubtoken)
fi
# }}}
# Commands to run at the end {{{
print_hosttag
# }}}
