-- All plugins that aren't in their own file
return {
  -- Editorconfig support
  'editorconfig/editorconfig-vim',

  -- Syntax/filetype specific
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

  -- My Plugins
  {'mivok/vim-minotl', ft='minotl'},
}
