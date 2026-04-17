-- Mason and related tools
vim.pack.add({
  gh('williamboman/mason.nvim'),
  gh('williamboman/mason-lspconfig.nvim'),
  gh('neovim/nvim-lspconfig'),
  gh('WhoIsSethDaniel/mason-tool-installer.nvim'),
})

require('mason').setup {}

require('mason-lspconfig').setup {
  ensure_installed = {
    -- Install these language servers by default. Note: use the lspconfig
    -- names, not the mason package names (e.g. bashls and not
    -- bash-language-server).
    -- See :MasonLog to verify installation
    'bashls',
    'cssls',
    'dockerls',
    'gopls',
    'html',
    'ts_ls',
    'jsonls',
    'lua_ls',
    'pylsp',
    'solargraph',
    'terraformls',
    'vimls',
    'yamlls',
  },
}

require('mason-tool-installer').setup {
  ensure_installed = {
    'goimports',
    'shellcheck',
    'yamllint',
    'tree-sitter-cli',
  }
}
