local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


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
