# Auto start an ssh agent if necessary
setup_ssh_agent() {
    local SSH_ENV_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
    local SSH_ENV_FILE="$SSH_ENV_DIR/ssh-agent.env"
    mkdir -p "$SSH_ENV_DIR"

    # On linux, use the systemd service if available
    # This requires a one-time setup command:
    # systemctl --user enable --now ssh-agent.socket
    if [[ -z "$SSH_AUTH_SOCK" && "$OSTYPE" == linux* && \
          -n "$XDG_RUNTIME_DIR" && -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]]; then
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    fi

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
