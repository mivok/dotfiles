-- Additional configuration for LSP
-- Note: LSP mappings are set in the `mappings.lua` file, and there are
-- additional LSP settings from mason-lspconfig.

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      return
    end

    -- Automatically highlight references
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "Visual" })
      vim.api.nvim_set_hl(0, "LspReferenceText", { link = "LspReferenceRead" })
      vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReferenceRead" })

      local group = vim.api.nvim_create_augroup("lsp_document_highlight",
        { clear = true })
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

    -- Enable LSP autocompletion
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end
})
