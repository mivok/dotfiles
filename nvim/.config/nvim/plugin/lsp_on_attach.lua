-- Defines the on_attach function which adds keybindings and other global
-- functionality to all language servers, and then sets it as the default
-- on_attach function.
local lspconfig = require('lspconfig')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
  -- Additional default mappings in nvim 0.11+
  -- grn - vim.lsp.buf.rename
  -- grr - vim.lsp.buf.references
  -- gri - vim.lsp.buf.implementation
  -- gra - vim.lsp.buf.code_action
  -- gO  - vim.lsp.buf.document_symbol
  -- CTRL-S - vim.lsp.buf.signature_help
  -- [d and ]d - vim.diagnostic.goto_prev and vim.diagnostic.goto_next

  -- Automatically highlight references
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "Visual" })
    vim.api.nvim_set_hl(0, "LspReferenceText", { link = "LspReferenceRead" })
    vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReferenceRead" })

    local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = group,
      buffer = 0,
      callback = vim.lsp.buf.document_highlight,
      desc = "Highlight references on cursor hold",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = 0,
      callback = vim.lsp.buf.clear_references,
      desc = "Clear references on cursor move",
    })
  end
end

lspconfig.util.default_config = vim.tbl_extend(
  "force", lspconfig.util.default_config, {on_attach = on_attach})
