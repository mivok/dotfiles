#!/bin/bash
# Moves a pre-existing file (or directory) into the dotfiles repo, adopting it
# with stow.
#
# Usage: ./adopt.sh FILE STOW_DIR
# Example: ./adopt.sh ~/.config/foo/foo.conf foo
# This will move ~/.config/foo/foo.conf to ./foo/.config/foo/foo.conf and run
# stow to create the symlink. Directories will be created as needed.

FILE="$1"
STOW_DIR="$2"
cd "$(dirname "$0")" || exit 1

if [[ -z "$FILE" || -z "$STOW_DIR" ]]; then
    echo "Usage: $0 FILE STOW_DIR"
    exit 1
fi

REL_PATH="${FILE/#$HOME\//}"

# replace any occurrence of . with dot- for better hidden file handling
REL_PATH="${REL_PATH//./dot-}"

if [[ "$REL_PATH" == "$FILE" ]]; then
    echo "Error: FILE must be inside the home directory"
    exit 1
fi

REL_DIR="${REL_PATH%/*}"

mkdir -p "$STOW_DIR/$REL_DIR"
mv "$FILE" "$STOW_DIR/$REL_PATH"
stow -v "$STOW_DIR"
