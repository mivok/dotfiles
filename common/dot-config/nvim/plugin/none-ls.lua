-- None LS - formatters, linters, extra completions
vim.pack.add({
  gh('nvimtools/none-ls.nvim'),
  gh('gbprod/none-ls-shellcheck.nvim'),
  gh('nvim-lua/plenary.nvim'),
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
