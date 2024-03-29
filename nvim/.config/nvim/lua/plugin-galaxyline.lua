-- Based on evilline.lua
local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section

gl.short_line_list = {'NvimTree', 'vista', 'dbui'}

table.insert(gls.left, {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {
        n = colors.green,
        i = colors.cyan,
        v = colors.blue,
        [''] = colors.blue,
        V = colors.blue,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red
      }
      vim.api
          .nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
      return '   '
    end,
    highlight = {colors.red, colors.bg, 'bold'}
  }
})

table.insert(gls.left, {
  FileType = {
    provider = 'FileTypeName',
    separator = ' ',
    condition = condition.buffer_not_empty,
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg
    }
  }
})

table.insert(gls.left, {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg
    }
  }
})

table.insert(gls.left, {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.magenta, colors.bg, 'bold'}
  }
})

table.insert(gls.left, {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red, colors.bg}
  }
})
table.insert(gls.left, {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow, colors.bg}
  }
})

table.insert(gls.left, {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.cyan, colors.bg}
  }
})

table.insert(gls.left, {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue, colors.bg}
  }
})

table.insert(gls.mid, {
  ShowLspClient = {
    provider = 'GetLspClient',
    icon = 'LSP: ',
    highlight = {colors.cyan, colors.bg, 'bold'}
  }
})

table.insert(gls.right, {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.green, colors.bg, 'bold'}
  }
})

table.insert(gls.right, {
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.green, colors.bg, 'bold'}
  }
})

table.insert(gls.right, {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.violet, colors.bg, 'bold'}
  }
})

table.insert(gls.right, {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {colors.violet, colors.bg, 'bold'}
  }
})

table.insert(gls.right, {
  GitBranchSpace = {
    provider = function () return ' ' end,
    condition = condition.check_git_workspace,
  }
})

table.insert(gls.right, {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.green, colors.bg}
  }
})

table.insert(gls.right, {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {colors.blue, colors.bg}
  }
})

table.insert(gls.right, {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red, colors.bg}
  }
})

table.insert(gls.right, {
  LineInfo = {
    provider = 'LineColumn',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.fg, colors.bg}
  }
})

table.insert(gls.right, {
  PerCent = {
    provider = 'LinePercent',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.fg, colors.bg, 'bold'}
  }
})

table.insert(gls.right, {
  FileSize = {
    provider = 'FileSize',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg, colors.bg}
  }
})

table.insert(gls.short_line_left, {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.blue, colors.bg, 'bold'}
  }
})

table.insert(gls.short_line_left, {
  SFileName = {
    provider = 'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg, colors.bg, 'bold'}
  }
})

table.insert(gls.short_line_right, {
  BufferIcon = {provider = 'BufferIcon', highlight = {colors.fg, colors.bg}}
})
