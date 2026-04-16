# Jira-cli settings

# My unresolved issues in all projects
alias jme="jira issue list -q 'assignee IN (currentUser()) AND resolution = \"unresolved\" AND project IS NOT EMPTY'"
