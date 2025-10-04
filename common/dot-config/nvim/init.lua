-- Basic vim settings
require('config.settings')
require('config.autocommands')
require('config.mappings')
require('config.python_venv')

-- Load lazy.nvim and plugins
require('config.lazy')

-- Additional config
require('config.lsp')
-- Custom commands
require('config.softwrap')
require('config.tabs')
