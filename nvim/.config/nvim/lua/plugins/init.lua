-- All plugins that aren't in their own file
return {
  -- Editorconfig support
  'editorconfig/editorconfig-vim',

  -- Syntax/filetype specific
  --Plug 'hynek/vim-python-pep8-indent'
  {'sirtaj/vim-openscad', ft = 'openscad'},
  {'ledger/vim-ledger', ft = 'ledger'},
  {'vito-c/jq.vim', ft = 'jq'},
  {'LokiChaos/vim-tintin', ft = 'tintin'},
  {'davidoc/taskpaper.vim', ft = 'taskpaper'},
  {'pearofducks/ansible-vim', ft = 'ansible'},
  {'bakpakin/fennel.vim', ft = 'fennel'},

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

  -- Snippets
  'rafamadriz/friendly-snippets',
  'hrsh7th/vim-vsnip',

  -- Better popup menu for commands
  -- Note: nvim-cmp can provide similar functionality, but I like this better
  {
    'gelguy/wilder.nvim',
    dependencies = {'romgrk/fzy-lua-native'},
    config = function() require('plugin-wilder') end
  },

  -- Startup time viewer
  {'dstein64/vim-startuptime', cmd = 'StartupTime'},

  -- My Plugins
  'mivok/vim-minotl',
}
