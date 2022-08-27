-- Helper function to set the tab size and hard vs soft tabs
function set_tab_width(width, opts)
	opts = opts or {}
  vim.opt_local.shiftwidth = width
  vim.opt_local.softtabstop = width
  if opts.hard_tab then
    vim.opt_local.tabstop = width
    vim.opt_local.expandtab = false
    -- Don't show hard tab chars if we are using
    vim.opt.listchars = {tab="  ", trail="-"}
  else
    vim.opt_local.tabstop = 8
    vim.opt_local.expandtab = true
    vim.opt.listchars = {tab=">-", trail="-"}
  end
end

-- Create :TabN and :RealTabN commands
local newcmd = vim.api.nvim_create_user_command
newcmd('Tab2', function() set_tab_width(2) end, {})
newcmd('Tab4', function() set_tab_width(4) end, {})
newcmd('RealTab2', function() set_tab_width(2, {hard_tab = true}) end, {})
newcmd('RealTab4', function() set_tab_width(4, {hard_tab = true}) end, {})
newcmd('RealTab8', function() set_tab_width(8, {hard_tab = true}) end, {})
