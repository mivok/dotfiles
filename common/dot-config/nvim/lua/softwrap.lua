-- Functions to turn on "soft" wrapping - i.e. don't automatically insert
-- newlines when typing past column 80, but also make line movement commands
-- move by screen lines instead of file lines to make navigation easier
function softwrap()
  -- Turn off hard wrapping
  vim.opt_local.textwidth = 0

  -- Make line movement commands move by screen lines instead of file lines
  local opts = {buffer = true, silent = true}

  vim.keymap.set('', '<Up>', 'gk', opts)
  vim.keymap.set('', '<Down>', 'gj', opts)
  vim.keymap.set('', '<Home>', 'g<Home>', opts)
  vim.keymap.set('', '<End>', 'g<End>', opts)

  vim.keymap.set('i', '<Up>', '<C-o>gk', opts)
  vim.keymap.set('i', '<Down>', '<C-o>gj', opts)
  vim.keymap.set('i', '<Home>', '<C-o>g<Home>', opts)
  vim.keymap.set('i', '<End>', '<C-o>g<End>', opts)

  vim.keymap.set('', 'k', 'gk', opts)
  vim.keymap.set('', 'j', 'gj', opts)
  vim.keymap.set('', '0', 'g0', opts)
  vim.keymap.set('', '$', 'g$', opts)
end

function hardwrap()
  -- Set textwidth back to normal
  vim.opt_local.textwidth = 80

  -- Remove the softwrap mappings
  local opts = {buffer = true}

  vim.keymap.del({'', 'i'}, '<Up>', opts)
  vim.keymap.del({'', 'i'}, '<Down>', opts)
  vim.keymap.del({'', 'i'}, '<Home>', opts)
  vim.keymap.del({'', 'i'}, '<End>', opts)

  vim.keymap.del('', 'k', opts)
  vim.keymap.del('', 'j', opts)
  vim.keymap.del('', '0', opts)
  vim.keymap.del('', '$', opts)
end

-- Make commands for the above functions
vim.api.nvim_create_user_command('SoftWrap', softwrap, {})
vim.api.nvim_create_user_command('HardWrap', hardwrap, {})
