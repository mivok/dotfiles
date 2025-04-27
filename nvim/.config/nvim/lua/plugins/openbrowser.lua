-- Better gx behavior
return {
  'tyru/open-browser.vim',
  init = function()
    -- Disable default netrw behavior
    vim.g.netrw_nogx = 1
  end,
  keys = {
    {"gx", "<Plug>(openbrowser-smart-search)", mode="n", desc="Open browser"},
    {"gx", "<Plug>(openbrowser-smart-search)", mode="v", desc="Open browser"},
  }
}
