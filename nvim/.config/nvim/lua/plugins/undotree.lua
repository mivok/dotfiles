-- Undotree
return {
  'mbbill/undotree',
  init = function()
    vim.g.undotree_SetFocusWhenToggle=1
    vim.g.undotree_ShortIndicators = 1
  end,
  keys = {
    {'<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Toggle undotree window'}
  },
}
