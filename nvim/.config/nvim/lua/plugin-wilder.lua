-- Setup for wilder - better autocompletion menu on : and /
-- https://github.com/gelguy/wilder.nvim
--
-- Note: python_search_pipeline and pcre2_highlighter need python3 to work.
-- Make sure a python virtualenv is installed.
--
-- Also, if it still doesn't work, run :UpdateRemotePlugins and restart
-- neovim. Packer does this automatically, but if python3 isn't working then
-- it won't do so.

local wilder = require('wilder')

wilder.setup({modes = {':', '/', '?'}})

-- Disable Python remote plugin - this way we don't _need_ a working python just
-- for autocompletion.
wilder.set_option('use_python_remote_plugin', 0)

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.substitute_pipeline({
      pipeline = wilder.vim_search_pipeline({skip_cmdtype_check = 1}),
      hide_in_replace = 1,
    }),
    wilder.cmdline_pipeline({
      fuzzy = 1,
      fuzzy_filter = wilder.lua_fzy_filter(),
    }),
    wilder.vim_search_pipeline()
  ),
})

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
      border = 'rounded',
      highlighter = wilder.lua_fzy_highlighter(),
      left = {
        ' ',
        wilder.popupmenu_devicons()
      },
      right = {
        ' ',
        wilder.popupmenu_scrollbar()
      },
    })
  ),
  ['/'] = wilder.wildmenu_renderer({
    highlighter = wilder.lua_fzy_highlighter(),
  }),
  substitute = wilder.wildmenu_renderer({
    highlighter = wilder.lua_fzy_highlighter(),
  })
}))
