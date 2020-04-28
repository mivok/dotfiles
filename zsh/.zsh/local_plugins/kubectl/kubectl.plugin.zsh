# Completion for kubectl using a cache, from oh-my-zsh's kubectl plugin
if (( $+commands[kubectl] )); then
    __KUBECTL_COMPLETION_FILE="${ZSH_CACHE_DIR}/kubectl_completion"

    if [[ ! -f $__KUBECTL_COMPLETION_FILE ]]; then
        kubectl completion zsh >! $__KUBECTL_COMPLETION_FILE
    fi

    [[ -f $__KUBECTL_COMPLETION_FILE ]] && source $__KUBECTL_COMPLETION_FILE

    unset __KUBECTL_COMPLETION_FILE
fi

# kcfg command - set the kubernetes config
kcfg() {
    if [[ -z "$1" ]]; then
        echo "Usage: kcfg CONFIG_FILE"
        echo
        echo "Sets the KUBECONFIG variable to the provided config file"
        return 1
    fi

    export KUBECONFIG="$HOME/.kube/${1/.config/}.config"
    echo "KUBECONFIG=$KUBECONFIG"
}

# Override kubectl to append context and namespace
kubectl() {
    local args
    args=()
    if [[ -n "$KUBENS" ]]; then
        args+=("--namespace" "$KUBENS")
    fi
    if [[ -n "$KUBECTX" ]]; then
        args+=("--context" "$KUBECTX")
    fi
    $commands[kubectl] "${args[@]}" "$@"
}

# Quick command to set the current namespace
kns() {
    export KUBENS="$1"
    echo "KUBENS=$KUBENS"
}

# Quick command to set the current context
kctx() {
    export KUBECTX="$1"
    echo "KUBECTX=$KUBENS"
}
