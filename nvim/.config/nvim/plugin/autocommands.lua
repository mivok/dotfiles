-- Autocommands

-- Make function names a bit smaller
local augroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Autocommand groups
local tab_width_group = augroup("tab_width", {clear = true})
local yank_highlight_group = augroup('yank_highlight', {clear = true})

-- Helper function and for setting the tab size for a given filetype
function filetype_tab_width(filetype, width, opts)
  opts = opts or {}
  vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = filetype,
    callback = function() set_tab_width(width, opts) end,
    group = tab_width_group,
  })
end

-- Set tab widths for specific filetypes
filetype_tab_width('gitconfig', 4, {hard_tab = true})
filetype_tab_width('go', 4, {hard_tab = true})
filetype_tab_width('javascript', 2)
filetype_tab_width('javascriptreact', 2)
filetype_tab_width('lua', 2)
filetype_tab_width('make', 8, {hard_tab = true})
filetype_tab_width('markdown', 2)
filetype_tab_width('ruby', 2)
filetype_tab_width('taskpaper', 4, {hard_tab = true})
filetype_tab_width('terraform', 2)
filetype_tab_width('yaml', 2)


-- Highlight text on yank
au({'TextYankPost'}, {
  pattern = '*',
  callback = function()
    require('vim.highlight').on_yank({
      higroup="IncSearch",
      timeout=500,
      on_visual=true
    }) end,
  group = yank_highlight_group
})

au({'FileType'}, {
  pattern = "json",
  callback = function()
    vim.opt.conceallevel = 0
  end
})
