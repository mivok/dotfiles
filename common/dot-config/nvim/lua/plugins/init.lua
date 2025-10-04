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

  -- My Plugins
  {'mivok/vim-minotl', ft='minotl'},
}
