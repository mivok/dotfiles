# Personal dotfiles

Collection of personal config files used on my machines.

These dotfiles are intended to be used with GNU stow.

## Installation

Clone the repo, then run `stow` for each package you want to install. To
install all of them, run `stow */` (the slash stops stow from trying to
install this README file).

```
cd ~
git clone git@github.com:mivok/dotfiles.git
cd dotfiles
brew install stow
stow -v */
```
