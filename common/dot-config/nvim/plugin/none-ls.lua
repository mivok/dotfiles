-- None LS - formatters, linters, extra completions
vim.pack.add({
  'https://github.com/nvimtools/none-ls.nvim',
  'https://github.com/gbprod/none-ls-shellcheck.nvim',
})

local null_ls = require("null-ls")

require("null-ls").setup {
  sources = {
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.mdl,
    null_ls.builtins.diagnostics.yamllint,
    require("none-ls-shellcheck.diagnostics"),
    require("none-ls-shellcheck.code_actions"),
  },
}
