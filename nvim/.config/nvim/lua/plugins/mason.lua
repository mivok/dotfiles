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
      config = function(_, opts)
        require('mason-lspconfig').setup(opts)

        -- All LSP setup goes here
        -- See :help mason-lspconfig-automatic-server-setup for how this works
        require('mason-lspconfig').setup_handlers {
            -- By default, just run the lspconfig setup without any args. This
            -- works for most simple language servers.
            function (server_name)
                require('lspconfig')[server_name].setup {}
            end,

            -- Override gopls settings.
            -- See https://github.com/golang/tools/blob/master/gopls/doc/vim.md
            ['gopls'] = function()
              require('lspconfig').gopls.setup {
                settings = {
                  gopls = {
                    analyses = {
                      unusedparams = true
                    },
                    staticcheck = true
                  }
                }
              }
            end,

            ['lua_ls'] = function()
              require'lspconfig'.lua_ls.setup {
                -- This sets the lua LSP up to work well when editing neovim configs
                -- Note: this slows down the lua language server startup a bit
                settings = {
                  Lua = {
                    runtime = {
                      -- Tell the language server which version of Lua you're using
                      -- (most likely LuaJIT in the case of Neovim)
                      version = 'LuaJIT',
                    },
                    diagnostics = {
                      -- Get the language server to recognize additional globals
                      -- vim for neovim, hs for hammerspoon
                      globals = {'vim', 'hs'},
                      -- Disable some recommendations
                      disable = {'lowercase-global'}
                    },
                    workspace = {
                      -- Make the server aware of Neovim runtime files
                      library = vim.api.nvim_get_runtime_file('', true),
                    },
                    -- Do not send telemetry data containing a randomized but
                    -- unique identifier
                    telemetry = {
                      enable = false,
                    },
                  },
                },
              }
            end,


            ['terraformls'] = function()
              require('lspconfig').terraformls.setup {
                single_file_support = true,
              }
            end,

            ['yamlls'] = function()
              require('lspconfig').yamlls.setup {
                settings = {
                  yaml = {
                    -- Custom yaml tags for cloudformation
                    -- See https://github.com/redhat-developer/vscode-yaml/issues/669
                    customTags = {
                      '!Base64 scalar',
                      '!Cidr scalar',
                      '!And sequence',
                      '!Equals sequence',
                      '!If sequence',
                      '!Not sequence',
                      '!Or sequence',
                      '!Condition scalar',
                      '!FindInMap sequence',
                      '!GetAtt scalar',
                      '!GetAtt sequence',
                      '!GetAZs scalar',
                      '!ImportValue mapping',
                      '!ImportValue scalar',
                      '!Join sequence',
                      '!Select sequence',
                      '!Split sequence',
                      '!Sub scalar',
                      '!Sub sequence',
                      '!Transform mapping',
                      '!Ref scalar',
                    }
                  }
                }
              }
            end,
        }
      end
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
