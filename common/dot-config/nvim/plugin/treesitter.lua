-- Treesitter
vim.pack.add({'https://github.com/nvim-treesitter/nvim-treesitter'})
-- build: :TSUpdate

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "c",
    "css",
    "go",
    "hcl",
    "html",
    "lua",
    "javascript",
    "json",
    "jsonc",
    "make",
    "markdown",
    "markdown_inline",
    "perl",
    "python",
    "ruby",
    "toml",
    "vim",
    "yaml",
  },
  highlight = {enable = true}
}
