-- Fix common typos
-- I often hold down shift too long when saving files
vim.keymap.set('ca', 'W', 'write')
vim.keymap.set('ca', 'Q', 'quit')

-- Abbreviations/Command remapping
vim.keymap.set('ia', 'xdate', '<C-R>=strftime("%Y-%m-%d")<CR>')
