-- Override gx
vim.g.netrw_nogx = 1
vim.api.nvim_set_keymap("n", "gx", "<Plug>(openbrowser-smart-search)", {})
vim.api.nvim_set_keymap("v", "gx", "<Plug>(openbrowser-smart-search)", {})
