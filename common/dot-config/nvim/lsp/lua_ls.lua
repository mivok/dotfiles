return {
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
