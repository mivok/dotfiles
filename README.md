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

When running make_symlinks, any options passed to the script will be passed to
stow. So you can use `-n` to do a dry run, or `-R` to restow.

## Adding new files

There is an `adopt.sh` script which can be used to move existing config files
into the dotfiles repo and create the necessary symlinks. Use it as follows:

```
./adopt.sh ~/path/to/config/file stow_dir
```
