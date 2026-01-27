return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    automatic_installation = true, -- installs LSP when you open a matching filetype
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
