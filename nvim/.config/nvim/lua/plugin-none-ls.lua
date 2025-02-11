local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.mdl,
    null_ls.builtins.diagnostics.yamllint,
    require("none-ls-shellcheck.diagnostics"),
    require("none-ls-shellcheck.code_actions"),
  },
})
