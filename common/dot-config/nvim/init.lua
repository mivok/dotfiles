-- Basic vim settings
require('config.settings')
require('config.autocommands')
require('config.mappings')
require('config.python_venv')

-- Additional config
require('config.lsp')
-- Custom commands
require('config.softwrap')
require('config.tabs')

-- Plugin helper functions/commands
require('plugin-helper')
