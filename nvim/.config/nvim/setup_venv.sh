#!/bin/bash
VENV_PATH="$HOME/.local/share/nvim/virtualenvs"

PACKAGES_BOTH=(pynvim)
PACKAGES_PYTHON3=()

echo "=> Ensuring $VENV_PATH exists"
mkdir -p "$VENV_PATH"
cd "$VENV_PATH" || exit 1

echo "=> Removing python3 directory"
rm -rf python3
echo "=> Creating new venv"
python3 -m venv python3
# shellcheck disable=SC1091
. python3/bin/activate
echo "=> Installing packages"
pip3 install "${PACKAGES_BOTH[@]}" "${PACKAGES_PYTHON3[@]}"
deactivate

echo "=> Removing (old) python2 directory"
rm -rf python2
