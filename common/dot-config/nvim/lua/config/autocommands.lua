-- Autocommands

-- Make function names a bit smaller
local augroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Autocommand groups
local tab_width_group = augroup("tab_width", {clear = true})
local yank_highlight_group = augroup('yank_highlight', {clear = true})
local filetype_group = augroup('mh_filetypes', {clear = true})
local conceal_group = augroup('mh_conceal', {clear = true})

-- Expand the home directory here because it's not automatically expanded in
-- autocommand definitions in lua
local homedir = vim.fn.expand("~")

-- Helper function for setting the tab size for a given filetype
local function filetype_tab_width(filetype, width, opts)
  opts = opts or {}
  vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = filetype,
    callback = function() set_tab_width(width, opts) end,
    group = tab_width_group,
  })
end

-- Helper function for disabling concealing for a given filetype
local function filetype_no_conceal(filetype)
  au({'FileType'}, {
    pattern = filetype,
    callback = function() vim.opt.conceallevel = 0 end,
    group = conceal_group,
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

-- Disable conceal for specific filetypes
filetype_no_conceal('markdown')
filetype_no_conceal('json')

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

-- Goimports function for formatting on save
-- From https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
function go_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params(0, "utf-8")
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
end

au("BufWritePre", {
    group = filetype_group,
    pattern = "*.go",
    callback = go_org_imports,
})
