-- Treesitter
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
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
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
