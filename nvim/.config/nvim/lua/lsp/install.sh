#!/bin/bash
# Installs all the language servers needed
npm install -g bash-language-server
npm install -g vscode-css-languageserver-bin
npm install -g dockerfile-language-server-nodejs
npm install -g vscode-html-languageserver-bin
npm install -g typescript typescript-language-server
npm install -g vscode-json-languageserver
npm install -g yaml-language-server

pipx install 'python-lsp-server[all]'

gem install solargraph

brew install gopls
brew install hashicorp/tap/terraform-ls
brew install efm-langserver

# Linters/formatters for efm
brew install shellcheck
luarocks install --server=https://luarocks.org/dev luaformatter
