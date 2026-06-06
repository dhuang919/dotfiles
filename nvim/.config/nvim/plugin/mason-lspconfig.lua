local gh = require("utils").gh

-- https://github.com/mason-org/mason-lspconfig.nvim
vim.pack.add({
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("mason-org/mason.nvim") },
  { src = gh("mason-org/mason-lspconfig.nvim") },
})

require("mason").setup()
require("mason-lspconfig").setup({
  -- Install lsps when opening a matching filetype
  automatic_installation = true
})
