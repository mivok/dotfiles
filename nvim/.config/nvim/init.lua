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
    -- See https://github.com/glepnir/galaxyline.nvim/issues/223 for why I'm
    -- using a fork here
    --'glepnir/galaxyline.nvim', branch = 'main',
    'Avimitin/galaxyline.nvim', branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require('plugin-galaxyline')
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

  -- LSP
  use {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function() require('plugin-mason') end
  }
  use 'neovim/nvim-lspconfig'

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
    },
    config = function() require('plugin-nvim-cmp') end
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('plugin-treesitter') end
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
    config = function() require('plugin-gitsigns') end
  }

  -- Telescope
  use {'nvim-telescope/telescope.nvim', branch='0.1.x'}

  -- Undotree
  use 'mbbill/undotree'

  -- Better gx
  use {
    'tyru/open-browser.vim',
    config = function() require('plugin-openbrowser') end
  }

  -- Better popup menu for commands
  -- Note: nvim-cmp can provide similar functionality, but I like this better
  use {
    'gelguy/wilder.nvim',
    requires = {'romgrk/fzy-lua-native'},
    config = function() require('plugin-wilder') end
  }

  -- Null LS - formatters, linters, extra completions
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function() require('plugin-null-ls') end
  }

  -- My Plugins
  use 'mivok/vim-minotl'
end)
