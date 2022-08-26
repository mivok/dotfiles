require("null-ls").setup({
  sources = {
    require("null-ls").builtins.diagnostics.ansiblelint,
    require("null-ls").builtins.diagnostics.mdl,
    require("null-ls").builtins.diagnostics.shellcheck,
    require("null-ls").builtins.diagnostics.yamllint,
  },
})
