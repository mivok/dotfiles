  -- None LS - formatters, linters, extra completions
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'gbprod/none-ls-shellcheck.nvim',
  },
  opts = function()
    local null_ls = require("null-ls")
    return {
      sources = {
        null_ls.builtins.diagnostics.ansiblelint,
        null_ls.builtins.diagnostics.mdl,
        null_ls.builtins.diagnostics.yamllint,
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
      },
    }
  end,
}
