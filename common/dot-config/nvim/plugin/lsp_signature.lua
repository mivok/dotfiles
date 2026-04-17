-- Plugin to automatically show function signatures in a floating window
vim.pack.add({gh('ray-x/lsp_signature.nvim')})
require('lsp_signature').setup {
  bind = true,
  handler_opts = {
    border = "rounded",
  },
}
