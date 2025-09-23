# Personal homebrew package list
# * Install: `brew bundle --global`
# * Verify installed packages:
#   `brew bundle --global check --no-upgrade --verbose`
# * Review what's missing from this file: `brew bundle --global cleanup`
#
# vim: ft=ruby

# Essentials
brew 'awscli'
brew 'fd'
brew 'git'
brew 'jq'
brew 'nvim'
brew 'ripgrep'
brew 'sd'
brew 'stow'

# Terminal
cask 'wezterm'

# Install homebrew bash which is newer than the macOS default
brew 'bash'
brew 'bash-completion@2' # @2 is the newer version that requires newer bash

# Shell helpers/tools
brew 'autojump'
brew 'colordiff'
brew 'direnv'
brew 'fzf'
brew 'tmux'
brew 'watch'
brew 'wdiff'

# Nice to haves
brew 'a2ps'
brew 'duckdb'
brew 'gem-mdl'
brew 'graphviz'
brew 'magic-wormhole'
brew 'mpv'
brew 'pwgen'
brew 'qrencode'
brew 'sox'
brew 'xz'
brew 'yq'


# Desktop helpers
brew 'pngpaste'
brew 'switchaudio-osx'

# Git tools
brew 'git-lfs'
brew 'gh'

# Devops tools
brew 'cli53'
brew 'kubernetes-cli'
brew 'k9s'
brew 'krew'
brew 'gomplate'
brew 'helm'
brew 'minikube'
brew 'pssh'

# Network tools
brew 'mtr'
brew 'mitmproxy'
brew 'ngrep'
brew 'nmap'
brew 'sipcalc'
brew 'socat'
brew 'telnet'

# Database tools
brew 'pgcli'
brew 'postgresql'
brew 'redis'

# Programming languages/tools
brew 'go'
brew 'go-bindata'
brew 'node'
brew 'openjdk'
brew 'python3'
brew 'ruby'
brew 'rust'
brew 'shellcheck'
brew 'uv'

# Hashicorp
brew 'packer'
brew 'tfenv'

# Fonts
cask 'font-hack-nerd-font'
cask 'font-hack'

# Mac apps (casks)
cask 'dash'
cask 'espanso'
cask 'gimp'
cask 'hammerspoon'

# Mac app store apps
brew 'mas' # The CLI to manage App Store things
mas 'Shush', id: 496437906
mas 'MindNode', id: 1289197285

if ENV['LOGNAME'] == 'mharrison'
  # Work only packages

  # Devops tools
  brew 'actionlint'
  brew 'angle-grinder'
  brew 'argo'
  brew 'argocd'
  brew 'awslogs'
  brew 'azure-cli'
  brew 'kafka'
  tap 'azure/kubelogin'
  brew 'azure/kubelogin/kubelogin'
  cask 'session-manager-plugin'

  # Git tools
  cask 'git-credential-manager'

  # Casks
  cask 'keeper-password-manager'
  cask 'rancher'

else
  # Personal only packages
  brew 'feh'
  brew 'graphicsmagick'
  brew 'minio-mc'
  brew 'ocrmypdf'
  brew 'rclone'
  brew 'sqldiff'
  brew 'typst'

  # SDR/Radio
  brew 'rtl_433'
  brew 'soapysdr'
  cask 'gqrx'
  cask 'chirp'

  # 3d printing
  cask 'openscad'
  cask 'ultimaker-cura'

  # Container tools
  brew 'cmctl' # cert-manager
  brew 'podman'
  cask 'podman-desktop'

  # MQTT
  brew 'mosquitto'
  cask 'mqttx'

  # Backups
  tap 'garethgeorge/backrest-tap'
  brew 'backrest'

  cask '1password'
  cask 'dungeon-crawl-stone-soup-tiles'
  cask 'raspberry-pi-imager'
  cask 'spotify'
  cask 'tailscale-app'
  cask 'vlc'
  cask 'whatsapp'
  cask 'zoom' # Installed by default on work
end
