-- Inline git blame
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    current_line_blame = true,
    onattach = function(bufnr)
      local gitsigns = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      map('n', '<leader>hs', gitsigns.stage_hunk, "Stage Hunk")
      map('n', '<leader>hr', gitsigns.reset_hunk, "Reset Hunk")

      map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, "Stage Hunk")

      map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, "Reset Hunk")
    end,
  },
}
