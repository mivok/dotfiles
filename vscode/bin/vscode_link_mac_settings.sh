#!/bin/bash -x
# The linux and mac settings locations are different, so this script will link
# from the linux location to the mac one
mkdir -p ~/Library/Application\ Support/Code/User
ln -sf ~/.config/Code/User/settings.json \
    ~/Library/Application\ Support/Code/User/settings.json
