-- Github Copilot
return {
  {
    -- Copilot itself
    'github/copilot.vim',
    init = function()
      -- Disable the default tab key mapping for copilot
      vim.g.copilot_no_tab_map = true

      -- Set the right arrow key as the accept trigger for copilot if a suggestion is
      -- visible
      vim.keymap.set('i', '<Right>', 'copilot#Accept("\\<Right>")', {
        expr = true,
        replace_keycodes = false
      })

      -- Set C-J as another trigger key for copilot
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
    end
  },
  {
    -- Copilot Chat
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatClose',
      'CopilotChatToggle',
      'CopilotChatStop',
      'CopilotChatReset',
      'CopilotChatSave',
      'CopilotChatLoad',
      'CopilotChatPrompts',
      'CopilotChatModels',
      'CopilotChatAgents',
    },
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {},
  },
}
