local gh = require("utils").gh
local lsps = require("config.lsps")

-- https://github.com/mason-org/mason-lspconfig.nvim
vim.pack.add({
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("mason-org/mason.nvim") },
  { src = gh("mason-org/mason-lspconfig.nvim") },
}, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(lsps) })
