# Support git/kubectl style custom subcommands, so 'foo bar' will call foo-bar
# instead.
#
# To use:
# foo() { subcmd foo "$@"} # Set up subcmd processing for foo
# foo-bar() { echo "Hello world" } # runs when 'foo bar' is called.
subcmd() {
  local cmd="$1"; shift
  local fq="${cmd}-${1-}"

  if (( $# )) && (( ${+functions[$fq]} )); then
    shift
    "$fq" "$@"
  elif (( $# )) && (( ${+commands[$fq]} )); then
    shift
    command "$fq" "$@"
  else
    command "$cmd" "$@"
  fi
}
