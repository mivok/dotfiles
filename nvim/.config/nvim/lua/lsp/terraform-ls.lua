-- brew install hashicorp/tap/terraform-ls
-- or download binary from https://releases.hashicorp.com/terraform-ls/
require('lspconfig').terraformls.setup {}

-- Autoformat on save
vim.cmd(
    [[au BufWritePre *.tf *.tfvars lua vim.lsp.buf.formatting_sync(nil, 100)]])
