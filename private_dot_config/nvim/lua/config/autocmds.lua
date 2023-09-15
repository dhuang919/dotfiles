local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


autocmd("BufEnter", {
  desc = "Don't extend comments to newlines with o/O",
  group = augroup("AutoComment", {}),
  callback = function()
    vim.opt_local.formatoptions:append("r")
    vim.opt_local.formatoptions:remove("c")
    vim.opt_local.formatoptions:remove("o")
  end,
})

autocmd("BufWritePre", {
  desc = "Auto-format go",
  pattern = "*.go",
  group = augroup("GoFormat", {}),
  callback = function()
    require("go.format").goimport()
  end,
})

autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  callback = function()
    vim.highlight.on_yank()
  end,
})
