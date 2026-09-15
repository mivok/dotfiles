-- Autoformatting
vim.pack.add({
  gh('stevearc/conform.nvim'),
})

require("conform").setup({
  formatters_by_ft = {
    -- Terraform
    terraform = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
  },

  -- Autoformat on save. Temporarily disable with ::FormatDisable
  format_on_save = function(bufnr)
    if vim.b[bufnr].disable_autoformat then
      return
    end

    return {
      lsp_format = "fallback",
      timeout_ms = 500,
    }
  end
})

-- Helper commands to toggle autoformatting on/off
vim.api.nvim_create_user_command("FormatDisable", function()
  vim.b.disable_autoformat = true
end, { desc = "Disable format-on-save for the current buffer" })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
end, { desc = "Enable format-on-save for the current buffer" })


