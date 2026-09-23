-- nvim-lint - linting
vim.pack.add({
  gh('mfussenegger/nvim-lint'),
})

require('lint').linters_by_ft = {
  ansible = { 'ansible_lint' },
  markdown = { 'rumdl' },
  yaml = { 'yamllint' },
  sh = { 'shellcheck' },
}
