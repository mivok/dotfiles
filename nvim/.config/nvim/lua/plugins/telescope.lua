-- Telescope
return {
  'nvim-telescope/telescope.nvim',
  branch='0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    -- Telescope mappings
    -- Default mappings
    {'<leader>ff', '<cmd>Telescope find_files<cr>', desc='Telescope find files'},
    {'<leader>fg', '<cmd>Telescope live_grep<cr>', desc='Telescope live grep'},
    {'<leader>fb', '<cmd>Telescope buffers<cr>', desc='Telescope buffers'},
    {'<leader>fh', '<cmd>Telescope help_tags<cr>', desc='Telescope help tags'},
    -- Also add \p to search git files
    {'<leader>p', '<cmd>Telescope git_files<cr>', desc='Telescope git files'},
  },
  cmd = {
    'Telescope',
  },
}
