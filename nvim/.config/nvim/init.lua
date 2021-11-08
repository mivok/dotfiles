-- Install packer
local install_path = vim.fn.stdpath('data') ..
  '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system {'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
    install_path}
  vim.api.nvim_command 'packadd packer.nvim'
  vim.api.nvim_command 'au VimEnter * PackerSync'
end


require('packer').startup(function(use)
  -- Packer manages itself
  use 'wbthomason/packer.nvim'

  -- Color scheme
  use {
    'ChristianChiarulli/nvcode-color-schemes.vim',
    config = function()
      vim.api.nvim_command('colorscheme lunar')
    end
  }

  use {
    'glepnir/galaxyline.nvim', branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require('galaxyline-config')
    end
  }

  -- Editorconfig support
  use 'editorconfig/editorconfig-vim'

  -- Syntax/filetype specific
  --Plug 'hynek/vim-python-pep8-indent'
  use 'hashivim/vim-terraform'
  use 'sirtaj/vim-openscad'
  use 'ledger/vim-ledger'
  use {'plasticboy/vim-markdown', requires = {'godlygeek/tabular'}}
  use 'vito-c/jq.vim'
  use 'LokiChaos/vim-tintin'
  use 'davidoc/taskpaper.vim'
  use 'pearofducks/ansible-vim'
  use 'bakpakin/fennel.vim'

  -- LSP/Autocompletion
  use 'neovim/nvim-lspconfig'
  use {
    'hrsh7th/nvim-compe',
    config = function() require('compe-config') end
  }
  use 'ray-x/lsp_signature.nvim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('treesitter-config') end
  }

  -- Snippets
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/vim-vsnip'

  -- Needed by a bunch of things (gitsigns, telescope)
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'

  -- Inline git blame
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns-config') end
  }

  -- Camelcase motion (\w, \b)
  use 'bkad/CamelCaseMotion'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'

  -- Undotree
  use 'mbbill/undotree'

  -- Better gx
  use {
    'tyru/open-browser.vim',
    config = function() require('openbrowser-config') end
  }

  -- My Plugins
  use 'mivok/vim-minotl'
end)
