-- Treesitter
vim.pack.add({'https://github.com/nvim-treesitter/nvim-treesitter'})
-- build: :TSUpdate

local nts = require('nvim-treesitter')

nts.setup {
  highlight = {enable = true}
}

nts.install {
  "c",
  "css",
  "go",
  "hcl",
  "html",
  "lua",
  "javascript",
  "json",
  "make",
  "markdown",
  "markdown_inline",
  "perl",
  "python",
  "ruby",
  "toml",
  "vim",
  "yaml",
}
