vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Set the indent after opening bracket
vim.g.python_indent = {
  open_paren = "shiftwidth()",
  continue = "shiftwidth()",
  closed_paren_align_last_line = false,
}
