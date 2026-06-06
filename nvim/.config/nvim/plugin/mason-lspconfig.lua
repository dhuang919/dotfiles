local gh = require("utils").gh

-- https://github.com/mason-org/mason-lspconfig.nvim
vim.pack.add({
  { src = gh("neovim/nvim-lspconfig"), version = vim.version.range("*") },
  { src = gh("mason-org/mason.nvim"), version = vim.version.range("*") },
  { src = gh("mason-org/mason-lspconfig.nvim"), version = vim.version.range("*") },
})

require("mason").setup()
require("mason-lspconfig").setup({
  -- Install lsps when opening a matching filetype
  automatic_installation = true
})
