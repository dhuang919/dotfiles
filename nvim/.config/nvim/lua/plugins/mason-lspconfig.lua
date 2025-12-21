local servers = require("lsp.servers")

return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = vim.tbl_keys(servers),
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
