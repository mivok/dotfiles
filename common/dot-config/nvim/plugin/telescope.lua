-- Telescope
vim.pack.add({
  {
    src = gh('nvim-telescope/telescope.nvim'),
    version = vim.version.range('*') -- any tagged version
  },
  gh('nvim-lua/plenary.nvim'),
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
