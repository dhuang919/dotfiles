local lsps = require("config.lsps")

return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = vim.tbl_keys(lsps),
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
