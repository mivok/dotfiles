-- Telescope
vim.pack.add({
  {src = 'https://github.com/nvim-telescope/telescope.nvim', version = '0.1.x'},
  'https://github.com/nvim-lua/plenary.nvim',
})

-- Telescope mappings
-- Default mappings
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {
  desc = 'Telescope find files'
})
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {
  desc = 'Telescope live grep'
})
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {
  desc = 'Telescope buffers'
})
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {
  desc = 'Telescope help tags'
})
-- Also add \p to search git files
vim.keymap.set('n', '<leader>p', '<cmd>Telescope git_files<cr>', {
  desc = 'Telescope git files'
})
