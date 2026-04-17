-- Quick helpers for specifying repos as plugins
function gh(repo) return 'https://github.com/' .. repo end
function cb(repo) return 'https://codeberg.org/' .. repo end

--
-- Commands that wrap the pack API for easier use
-- Eventually these may be replaced with neovim builtins if they are implemented
-- in a later version.
--

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, { desc = 'Update plugins' })

vim.api.nvim_create_user_command('PackClean', function()
  -- Get the list of plugins that are not active (i.e. not in the config) and
  -- remove them. This is useful for cleaning up plugins that are no longer
  -- used but still exist in the pack directory (and get added to the lockfile)
  local plugins_to_remove = {}
  for _, plugin in ipairs(vim.pack.get()) do
    if not plugin.active then
      table.insert(plugins_to_remove, plugin.spec.name)
    end
  end
  -- print the plugins to remove so the user knows what is being cleaned, and
  -- ask the user to confirm
  if #plugins_to_remove == 0 then
    print('No plugins to remove')
    return
  end
  print('The following plugins will be removed:')
  for _, plugin in ipairs(plugins_to_remove) do
    print("- " .. plugin)
  end
  local confirm = vim.fn.input('Are you sure? (y/n) ')
  if confirm:lower() ~= 'y' then
    print('Aborting plugin removal')
    return
  end
  vim.pack.del(plugins_to_remove)
  print('Removed ' .. #plugins_to_remove .. ' plugins')
end, { desc = 'Remove unused plugins' })

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update(nil, { force = true })
end, { desc = 'Update plugins' })

vim.api.nvim_create_user_command('PackList', function()
  local plugins = vim.pack.get()
  if #plugins == 0 then
    print('No plugins installed')
    return
  end
  print('Installed plugins:')
  for _, plugin in ipairs(plugins) do
    print("- " .. plugin.spec.name)
  end
end, { desc = 'List installed plugins' })
