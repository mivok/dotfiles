# functions.plugin.zsh
# Miscellaneous helper functions

# SSH to an aws instance by looking up its IP. Uses aws_instance_search.sh and
# fzf
aws-ssh() {
    local HOSTNAME
    HOSTNAME="$(aws_instance_search.sh -p "$1" -r "${3:-us-west-2}" "$2" | \
        fzf -1 | tee /dev/stderr | awk '{ print $2 }')"
    if [[ -n "$HOSTNAME" ]]; then
        ssh "$HOSTNAME"
    else
        echo "No host selected."
    fi
}

# For when you recreate a machine and try to ssh to it
fussh() {
    local SSH_ARG SSH_HOST SSH_IP PROXYJUMP
    SSH_ARG="$1"
    if [[ -z $SSH_ARG ]]; then
        SSH_ARG="$(history -p '!!:$' | sed "s/.*@//")"
    fi
    SSH_HOST="$(ssh -G "$SSH_ARG" | awk '$1 == "hostname" { print $2 }')"
    SSH_IP="$(dig +short "$SSH_HOST")"
    ssh-keygen -R "$SSH_HOST"
    if [[ -n "$SSH_IP" ]]; then
        ssh-keygen -R "$SSH_IP"
    fi
    # Deal with bastions too
    PROXYJUMP="$(ssh -G "$SSH_ARG" | awk '$1 == "proxyjump" { print $2 }')"
    if [[ -n $PROXYJUMP ]]; then
        fussh "$PROXYJUMP"
    fi
}

# Alias to switch between stage/prod directories
cde() {
    emulate -L zsh -o GLOB_SUBST
    if [[ $PWD =~ /(stage|staging)/ ]]; then
        cd ${PWD/\/stag*\//\/prod*\/} || return
        pwd
    elif [[ $PWD =~ /(prod)/ ]]; then
        cd ${PWD/\/prod*\//\/stag*\/} || return
        pwd
    else
        echo "Skipping cd: Outside of a stage/prod directory"
    fi
}

# Fzf cd command relative to the current git root
cdg() {
    local GIT_ROOT
    GIT_ROOT="$(git rev-parse --show-toplevel)"
    cd "$GIT_ROOT" || return
    DIR="$(fd --type d --hidden --follow --exclude .git | fzf -q "$*" -1)"
    if [[ -n "$DIR" ]]; then
        echo "$DIR"
        cd "$DIR" || cd "$OLDPWD" || return
    else
        cd "$OLDPWD" || return
    fi
}

# Switch branch in git using fzf
gco() {
    git switch $(git for-each-ref --format='%(refname:short)' refs/heads | \
        fzf -q "$1" -1)
}

# Alternative to antigen selfupdate command
update-antigen() {
    (cd -q ~/dotfiles/zsh/.zsh
        if [[ ! -f antigen.zsh ]]; then
            echo "Antigen doesn't appear to be installed as a single script."
            echo "Skipping update."
            return 1
        fi

        curl -L -o antigen.zsh https://git.io/antigen
        echo "Antigen updated. Commit/push dotfiles as needed."
    )
}
