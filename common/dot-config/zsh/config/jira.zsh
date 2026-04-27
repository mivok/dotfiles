# Jira-cli settings

# Suport custom subcommands in jira
jira() { subcmd jira "$@" }

# My issues
jira-mine() { command jira issue list -q '
    assignee IN (currentUser())
        AND resolution = "unresolved"
        AND project IS NOT EMPTY
    '
}

# Quick search alias
jira-search() { command jira issue list -R unresolved "$@" }
