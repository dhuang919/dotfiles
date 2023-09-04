return {
  "ray-x/go.nvim",

  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "ray-x/guihua.lua",
  },

  event = "CmdlineEnter",

  config = function()
    require("go").setup()
  end,

  ft = { "go", "gomod" },
}
