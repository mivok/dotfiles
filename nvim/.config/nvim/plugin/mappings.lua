-- Mappings config

-- Sudo make me a sandwich
vim.keymap.set('c', 'w!!', '%!sudo tee > /dev/null %')

-- Shift-Tab to unindent
vim.keymap.set('n', '<S-Tab>', '<<')
vim.keymap.set('i', '<S-Tab>', '<C-d>')

-- Use J and K in visual mode to move lines up and down
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

-- Make > and < keep the visual selection
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

-- Fix common typos
-- I often hold down shift too long when saving files
vim.keymap.set('ca', 'W', 'write')
vim.keymap.set('ca', 'Q', 'quit')

-- Abbreviations/Command remapping
vim.keymap.set('ia', 'xdate', '<C-R>=strftime("%Y-%m-%d")<CR>')
