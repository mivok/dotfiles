-- Mappings config

-- Sudo make me a sandwich
vim.keymap.set('c', 'w!!', '%!sudo tee > /dev/null %')

-- Toggle paste on/off
vim.opt.pastetoggle = '<F2>'

-- Shift-Tab to unindent
vim.keymap.set('n', '<S-Tab>', '<<')
vim.keymap.set('i', '<S-Tab>', '<C-d>')

-- Use J and K in visual mode to move lines up and down
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

-- Make > and < keep the visual selection
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')
