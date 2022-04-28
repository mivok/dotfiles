-- Healthchecks for LSP plugins
-- Use with :checkhealth lsp to verify everything is running ok
-- Use the install.sh script to do the initial install

local M = {}
local health = require("health")

local lsp_commands = {
  pylsp = "pylsp -V",
  bash = "bash-language-server -v",
  css = "which css-languageserver",
  docker ="which docker-langserver",
  html = "which html-languageserver",
  typescript = "typescript-language-server -V",
  json = "which vscode-json-languageserver",
  yaml = "which yaml-language-server",
  solargraph = "solargraph -v",
  gopls = "gopls version",
  terraform = "terraform-ls -version",
  efm = "efm-langserver -v"
}

M.check = function()
  health.report_start("LSP servers report")
  -- Loop through each LSP binary and make sure it runs ok
  for k, v in pairs(lsp_commands) do
    vim.fn.system(v)
    if vim.v['shell_error'] == 0 then
      health.report_ok("LSP server "..k.." is available")
    else
      health.report_error("LSP server "..k.." isn't working ('"
        ..v.."' failed)")
    end
  end
end

return M
