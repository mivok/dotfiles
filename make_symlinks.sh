#!/bin/bash
shopt -s extglob

DIRS=(common)

case "$(uname -s)" in
    Linux) DIRS+=(linux) ;;
    Darwin) DIRS+=(mac) ;;
esac

stow -v "$@" "${DIRS[@]}"
