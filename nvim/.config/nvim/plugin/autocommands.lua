-- Autocommands

-- Make function names a bit smaller
local augroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Autocommand groups
local tab_width_group = augroup("tab_width", {clear = true})
local yank_highlight_group = augroup('yank_highlight', {clear = true})
local filetype_group = augroup('mh_filetypes', {clear = true})

-- Expand the home directory here because it's not automatically expanded in
-- autocommand definitions in lua
local homedir = vim.fn.expand("~")

-- Helper function and for setting the tab size for a given filetype
function filetype_tab_width(filetype, width, opts)
  opts = opts or {}
  vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = filetype,
    callback = function() set_tab_width(width, opts) end,
    group = tab_width_group,
  })
end

-- Set tab widths for specific filetypes
filetype_tab_width('gitconfig', 4, {hard_tab = true})
filetype_tab_width('go', 4, {hard_tab = true})
filetype_tab_width('javascript', 2)
filetype_tab_width('javascriptreact', 2)
filetype_tab_width('lua', 2)
filetype_tab_width('make', 8, {hard_tab = true})
filetype_tab_width('markdown', 2)
filetype_tab_width('ruby', 2)
filetype_tab_width('taskpaper', 4, {hard_tab = true})
filetype_tab_width('terraform', 2)
filetype_tab_width('yaml', 2)


-- Highlight text on yank
au({'TextYankPost'}, {
  pattern = '*',
  callback = function()
    vim.hl.on_yank({
      higroup="IncSearch",
      timeout=500,
      on_visual=true
    }) end,
  group = yank_highlight_group
})

au({'FileType'}, {
  pattern = "json",
  callback = function()
    vim.opt.conceallevel = 0
  end
})


-- Filetype autocommands
-- Fix for gq on lists with plasticboy plugin - platicboy/vim-markdown#232
au("FileType", {
    group = filetype_group,
    pattern = "markdown",
    callback = function()
        vim.opt_local.formatoptions:remove("q")
        vim.opt_local.formatlistpat = [[^\s*\d\+\.\s\+\|^\s*[-*+]\s\+]]
    end,
})

-- Taskpaper settings
au("FileType", {
    group = filetype_group,
    pattern = "taskpaper",
    callback = function()
        vim.opt_local.textwidth = 0
        vim.opt_local.autoread = true
        au({ "CursorHold", "FocusLost", "WinLeave" }, {
            buffer = 0,
            callback = function()
                vim.cmd("update")
            end,
        })
        au({ "FocusGained", "BufEnter" }, {
            buffer = 0,
            callback = function()
                vim.cmd("checktime")
            end,
        })
    end,
})

-- Set filetypes for specific extensions
au("BufEnter", {
    group = filetype_group,
    pattern = "*.tfstate",
    callback = function()
        vim.opt_local.filetype = "json"
    end,
})

-- Notes settings
au("BufEnter", {
    group = filetype_group,
    pattern = { homedir .. "/notes/*.md", homedir .. "/git/personal/notes/*.md" },
    callback = function()
        vim.cmd("SoftWrap")
    end,
})

-- Crontab -e fix
au("BufEnter", {
    group = filetype_group,
    pattern = "/private/tmp/crontab.*",
    callback = function()
        vim.opt_local.backupcopy = "yes"
    end,
})
