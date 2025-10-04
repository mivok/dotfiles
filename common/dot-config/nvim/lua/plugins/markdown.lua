return {
  'plasticboy/vim-markdown',
  dependencies = {'godlygeek/tabular'},
  ft = 'markdown',
  init = function()
    -- Markdown plugin settings
    vim.g.markdown_fenced_languages = {'html', 'python', 'ruby', 'bash=sh'}
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_frontmatter = 1
    vim.g.vim_markdown_toml_frontmatter = 1
    --vim.g.vim_markdown_json_frontmatter = 1
    vim.g.vim_markdown_new_list_item_indent = 2
    vim.g.vim_markdown_conceal_code_blocks = 0
  end
}
