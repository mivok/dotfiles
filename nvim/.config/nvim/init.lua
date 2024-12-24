-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Color scheme
  {
    'ChristianChiarulli/nvcode-color-schemes.vim',
    config = function()
      vim.api.nvim_command('colorscheme lunar')
    end
  },

  {
    -- See https://github.com/glepnir/galaxyline.nvim/issues/223 for why I'm
    -- using a fork here
    --'glepnir/galaxyline.nvim', branch = 'main',
    'Avimitin/galaxyline.nvim', branch = 'main',
    dependencies = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require('plugin-galaxyline')
    end
  },

  -- Editorconfig support
  'editorconfig/editorconfig-vim',

  -- Syntax/filetype specific
  --Plug 'hynek/vim-python-pep8-indent'
  {'hashivim/vim-terraform', ft = 'terraform'},
  {'sirtaj/vim-openscad', ft = 'openscad'},
  {'ledger/vim-ledger', ft = 'ledger'},
  {'plasticboy/vim-markdown',
    dependencies = {'godlygeek/tabular'},
    ft = 'markdown',
  },
  {'vito-c/jq.vim', ft = 'jq'},
  {'LokiChaos/vim-tintin', ft = 'tintin'},
  {'davidoc/taskpaper.vim', ft = 'taskpaper'},
  {'pearofducks/ansible-vim', ft = 'ansible'},
  {'bakpakin/fennel.vim', ft = 'fennel'},

  -- LSP
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function() require('plugin-mason') end
  },
  'neovim/nvim-lspconfig',

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
    },
    config = function() require('plugin-nvim-cmp') end
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function() require('plugin-treesitter') end
  },

  -- Snippets
  'rafamadriz/friendly-snippets',
  'hrsh7th/vim-vsnip',

  -- Needed by a bunch of things (gitsigns, telescope)
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',

  -- Inline git blame
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugin-gitsigns') end
  },

  -- Telescope
  {'nvim-telescope/telescope.nvim', branch='0.1.x'},

  -- Undotree
  'mbbill/undotree',

  -- Better gx
  {
    'tyru/open-browser.vim',
    config = function() require('plugin-openbrowser') end
  },

  -- Better popup menu for commands
  -- Note: nvim-cmp can provide similar functionality, but I like this better
  {
    'gelguy/wilder.nvim',
    dependencies = {'romgrk/fzy-lua-native'},
    config = function() require('plugin-wilder') end
  },

  -- Null LS - formatters, linters, extra completions
  {
    'nvimtools/none-ls.nvim',
    config = function() require('plugin-null-ls') end
  },

  -- Startup time viewer
  {'dstein64/vim-startuptime', cmd = 'StartupTime'},

  -- Github copilot
  {
    'github/copilot.vim',
    config = function() require('plugin-copilot') end
  },

  -- My Plugins
  'mivok/vim-minotl',
})
