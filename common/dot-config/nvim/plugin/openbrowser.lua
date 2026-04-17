-- Better gx behavior
vim.pack.add({gh('tyru/open-browser.vim')})

-- Disable default netrw behavior
vim.g.netrw_nogx = 1

vim.keymap.set('n', "gx", "<Plug>(openbrowser-smart-search)", {
  desc = "Open browser"
})
vim.keymap.set('v', "gx", "<Plug>(openbrowser-smart-search)", {
  desc = "Open browser"
})
