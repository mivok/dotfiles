# aliases.plugin.zsh

# Short dig alias
alias sdig='dig +short'

# mDNS dig
alias mdig='dig @224.0.0.251 -p 5353 +time=1 +tries=1'

# Perl timestamp alias
alias perlts='perl -p -e "s/^(\d+)/localtime(\$1)/e"'

# List running vms
alias runningvms="VBoxManage list runningvms | awk -F'\"' '{print \$2}'"
alias runningcontainers="docker ps --format '{{.Image}}\\t{{.Names}}'"

# Saml2aws login alias
alias s2al='saml2aws login --skip-prompt'

# Azure logins
alias azl='az login --tenant valimailappprod.onmicrosoft.com'
alias azs='az account set --subscription "Valimail Staging"'
alias azp='az account set --subscription "Valimail Prod"'

# Use nvim if available
if (($+commands[nvim])); then
    alias vim=nvim
fi

# Use hub command if available
if (($+commands[hub])); then
    alias git=hub
fi
