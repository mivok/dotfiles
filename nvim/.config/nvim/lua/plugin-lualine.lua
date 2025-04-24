function copilot()
  -- Return the github icon if copilot is active. Use the copilot#Enabled
  -- vimscript function to check if copilot is active.
  if vim.fn['copilot#Enabled']() == 1 then
    return ''
  else
    return ''
  end
end

require('lualine').setup {
  options = {
    theme = 'auto',
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      -- Single letter mode indicator
      { 'mode', fmt = function(str) return str:sub(1,1) end }
    },
    lualine_b = {'filename', copilot, 'diagnostics'},
    lualine_c = {
      {
        'lsp_status',
        ignore_lsp = { 'null-ls', 'GitHub Copilot' },
      }
    },

    lualine_x = {'fileformat', 'filetype'}
  },
}
