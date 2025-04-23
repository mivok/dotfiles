-- Custom settings
vim.opt.title = true                   -- Xterm title bar
vim.opt.showmatch = true               -- Show matching parentheses
vim.opt.list = true                    -- Show trailing spaces and tabs
vim.opt.listchars = {tab=">-", trail="-"}
vim.opt.scrolloff = 2                  -- Always show lines above/below cursor
vim.opt.ignorecase = true              -- Ignore case in searches
vim.opt.smartcase = true               -- ... unless the search term has caps
vim.opt.iskeyword:append({'$','%','#'}) -- Chars not to be word separators
vim.opt.shada:append('%')              -- Save/restore buffer list
vim.opt.timeoutlen = 500               -- timeout value in ms
vim.opt.conceallevel = 2               -- Enable concealed text
vim.opt.mouse = 'a'                    -- Enable the mouse
vim.opt.formatoptions:append('j')      -- Delete comment chars when joining lines
vim.opt.updatetime = 500               -- Make CursorHold respond much quicker
vim.opt.termguicolors = true           -- Enable truecolor terminal support

-- Line/column settings
vim.opt.signcolumn = 'yes'             -- Always display the sign column
vim.opt.colorcolumn = {'80'}           -- Highlight column 80
vim.opt.textwidth = 80                 -- Word wrapping
if vim.o.columns > (vim.o.textwidth + vim.o.numberwidth) then
  vim.opt.number = true                  -- Display line numbers
end

-- Wrapping options
vim.opt.linebreak = true               -- Visually wrap at word boundaries
vim.opt.showbreak = '\\'               -- Mark manually wrapped lines with \
vim.opt.breakindent = true             -- Indent wrapped lines
vim.opt.breakindentopt = {shift=2, sbr=true} -- Additionally indent wrapped lined by 2

-- Multi buffer/window settings
vim.opt.switchbuf:append('useopen') -- Use existing windows (not tabs)

-- Default tab settings
vim.opt.tabstop = 8                    -- Hard tabs are 8 chars
vim.opt.softtabstop = 4                -- Tab key indents by 4 chars
vim.opt.shiftwidth = 4                 -- Autoindent by 4 chars
vim.opt.expandtab = true               -- Use spaces instead of tabs

-- Diagnostics configuration
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { current_line = true },
})
