-- Terraform plugin
return {
  'hashivim/vim-terraform',
  ft = 'terraform',
  init = function()
    vim.g.terraform_fmt_on_save = 1
  end,
}
