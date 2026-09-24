# ZSH autoexpanding date abbreviations
typeset -A ZLE_ABBRS=(
  xdate    '%Y-%m-%d'
  xid      '%Y%m%d%H%M%S'
  xisodate '%Y-%m-%dT%H:%M:%S%Z'
)

expand-abbr-and-space() {
  local word="${LBUFFER##* }"
  local format="${ZLE_ABBRS[$word]}"

  if [[ -n "$format" ]]; then
    LBUFFER="${LBUFFER%$word}$(date +"$format")"
  fi

  LBUFFER+=" "
}

zle -N expand-abbr-and-space
bindkey ' ' expand-abbr-and-space
