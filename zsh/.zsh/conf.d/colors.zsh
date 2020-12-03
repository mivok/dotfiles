# colors.plugin.zsh
# Man page and LS colors

# Color man pages
export LESS_TERMCAP_mb=$BRIGHT$RED        # begin blinking
export LESS_TERMCAP_md=$BRIGHT$BLUE       # begin bold
export LESS_TERMCAP_me=$RESET             # end mode
export LESS_TERMCAP_se=$RESET             # end standout-mode
export LESS_TERMCAP_so=$CYAN              # begin standout-mode - info box
export LESS_TERMCAP_ue=$RESET             # end underline
export LESS_TERMCAP_us=$UNDERLINE$CYAN    # begin underline

# Color ls (Mac)
export CLICOLOR=YES
# Make the colors like dircolors defaults
export LSCOLORS="ExGxFxdxCxDaDahbadacec"

# Color less
export LESS="-R"
export LESSQUIET=1
