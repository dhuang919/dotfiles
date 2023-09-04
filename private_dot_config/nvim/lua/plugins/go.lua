return {
  "ray-x/go.nvim",

  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },

  event = "CmdlineEnter",

  config = function()
    require("go").setup()
  end,

  ft = { "go", "gomod" },
}
