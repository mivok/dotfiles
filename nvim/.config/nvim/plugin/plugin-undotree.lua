-- undotree configuration
vim.g.undotree_SetFocusWhenToggle=1
vim.g.undotree_ShortIndicators = 1

-- \u to toggle the undotree window
vim.keymap.set('n', '<leader>u', function() vim.cmd('UndotreeToggle') end)
