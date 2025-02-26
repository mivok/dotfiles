# aliases.plugin.zsh

# Short dig alias
alias sdig='dig +short'

# mDNS dig
alias mdig='dig @224.0.0.251 -p 5353 +time=1 +tries=1'

# Perl timestamp alias
alias perlts='perl -p -e "s/^(\d+)/localtime(\$1)/e"'

# Use nvim if available
if (($+commands[nvim])); then
    alias vim=nvim
fi

# Ensure minikube uses its own config file
alias minikube='KUBECONFIG=$HOME/.kube/minikube.config minikube'
