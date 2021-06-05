""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim_plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Color scheme
Plug 'https://github.com/ChristianChiarulli/nvcode-color-schemes.vim'

" Editorconfig support
Plug 'editorconfig/editorconfig-vim'

" Syntax/filetype specific
"Plug 'hynek/vim-python-pep8-indent'
Plug 'hashivim/vim-terraform'
Plug 'sirtaj/vim-openscad'
Plug 'ledger/vim-ledger'
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'vito-c/jq.vim'
Plug 'LokiChaos/vim-tintin'
Plug 'davidoc/taskpaper.vim'
Plug 'pearofducks/ansible-vim'
Plug 'bakpakin/fennel.vim'

" LSP/Autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'ray-x/lsp_signature.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'

" Needed by a bunch of things (gitsigns, telescope)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" Inline git blame
Plug 'lewis6991/gitsigns.nvim'

" Status line
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons'

" Camelcase motion (\w, \b)
Plug 'bkad/CamelCaseMotion'

" Telescope
Plug 'nvim-telescope/telescope.nvim'

" My Plugins
Plug 'mivok/vim-minotl'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look and feel options
colorscheme lunar

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use specific virtualenvs for neovim python
let venv_path = $HOME . '/.local/share/nvim/virtualenvs'
let g:python3_host_prog = venv_path . '/python3/bin/python3'

" Load lua config files
lua <<EOF
require('compe-config')
require('lsp')
require('treesitter')
require('galaxyline-config')
require('gitsigns-config')
EOF
