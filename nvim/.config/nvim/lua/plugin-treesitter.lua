require('nvim-treesitter.configs').setup {
  -- Enable treesitter for these languages
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
    "perl",
    "python",
    "ruby",
    "toml",
    "vim",
    "yaml",
  },
  highlight = {enable = true}
}
