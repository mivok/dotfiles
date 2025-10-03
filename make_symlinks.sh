#!/bin/bash
shopt -s extglob

case "$(uname -s)" in
    Linux) DIRS=(!(mac)/) ;;
    Darwin) DIRS=(!(linux)/) ;;
    *) echo "Unsupported OS"; exit 1 ;;
esac

stow -v "$@" "${DIRS[@]}"
