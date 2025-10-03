# Personal dotfiles

Collection of personal config files used on my machines.

These dotfiles are intended to be used with GNU stow.

## Installation

Clone the repo, install stow, then run `make_symlinks.sh`, which uses stow to
install symlinks for each dotfile. Use the script rather than stow directly as
the script will detect the OS and exclude mac/linux specific config files as
needed.

```
cd ~
git clone git@github.com:mivok/dotfiles.git
cd dotfiles
brew install stow # or yay -S stow
./make_symlinks.sh
```
