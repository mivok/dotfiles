-- Mason and related tools
return {
  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    opts = {}
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
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
    },
  },
  {
    -- Auto install other tools, used by null-ls
    -- Eventually there may be a mason-null-ls package, but for now this uses
    -- mason-tool-installer.
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      ensure_installed = {
        'goimports',
        'shellcheck',
        'yamllint',
      }
    }
  },
}
