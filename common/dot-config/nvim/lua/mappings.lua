-- Mappings config

-- Sudo make me a sandwich
vim.keymap.set('c', 'w!!', '%!sudo tee > /dev/null %',
  {desc="Write file with sudo"})

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

-- LSP Mappings
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
  {noremap=true, silent=true, desc="View diagnostic information"})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
  {noremap=true, silent=true, desc="View diagnostics in loclist"})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
  {noremap=true, silent=true, desc="View symbol declaration"})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
  {noremap=true, silent=true, desc="View symbol definition"})
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
  {noremap=true, silent=true, desc="Add LSP workspace folder"})
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
  {noremap=true, silent=true, desc="Remove LSP workspace folder"})
vim.keymap.set('n', '<leader>wl', function()
  vim.primt(vim.lsp.buf.list_workspace_folders())
end,
  {noremap=true, silent=true, desc="List LSP workspace folders"})
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
  {noremap=true, silent=true, desc="View symbol type definition"})
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format,
  {noremap=true, silent=true, desc="Format buffer"})
-- Additional default mappings in nvim 0.11+
-- grn - vim.lsp.buf.rename
-- grr - vim.lsp.buf.references
-- gri - vim.lsp.buf.implementation
-- gra - vim.lsp.buf.code_action
-- gO  - vim.lsp.buf.document_symbol
-- CTRL-S - vim.lsp.buf.signature_help
-- [d and ]d - vim.diagnostic.goto_prev and vim.diagnostic.goto_next

-- Tab, Shift-Tab and CR mappings - these do different things and need special
-- treatment, so we deal with them all in one place. Any other special behavior
-- (e.g. snippet expansion) should be handled here.

-- Tab
vim.keymap.set('i', '<Tab>', function()
  if vim.fn.pumvisible() == 1 then
    -- If the completion menu is visible, select the next item
    return '<C-n>'
  else
    -- Otherwise return a normal tab
    return '<Tab>'
  end
end, {expr = true, noremap = true})

-- Shift-Tab
vim.keymap.set('i', '<S-Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-p>'
  else
    -- Unindent in insert mode
    return '<C-d>'
    -- return '<S-Tab>'
  end
end, {expr = true, noremap = true})

-- Shift-Tab in normal mode unindents
vim.keymap.set('n', '<S-Tab>', '<<')

-- CR in insert mode
vim.keymap.set('i', '<CR>', function()
  if vim.fn.pumvisible() == 1 then
    -- If the completion menu is visible, accept the selected item
    return '<C-y>'
  else
    -- Otherwise return a normal CR
    return '<CR>'
  end
end, {expr = true, noremap = true})
