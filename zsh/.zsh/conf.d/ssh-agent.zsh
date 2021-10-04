# Auto start an ssh agent if necessary
setup_ssh_agent() {
    local SSH_ENV_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
    local SSH_ENV_FILE="$SSH_ENV_DIR/ssh-agent.env"
    mkdir -p "$SSH_ENV_DIR"

    if [[ -z "$SSH_AUTH_SOCK" ]]; then
        if [[ -f "$SSH_ENV_FILE" ]]; then
            source "$SSH_ENV_FILE" > /dev/null
        fi

        if [[ -z "$SSH_AGENT_PID" ]] || ! ps -p "$SSH_AGENT_PID" > /dev/null; then
            ssh-agent > "$SSH_ENV_FILE"
            source "$SSH_ENV_FILE" > /dev/null
        fi
    fi
}
setup_ssh_agent
