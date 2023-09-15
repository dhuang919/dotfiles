return {
  "ray-x/go.nvim",

  dependencies = {
    {
      "mfussenegger/nvim-dap",
      event = "VeryLazy",
    },
    {
      "rcarriga/nvim-dap-ui",
      event = "VeryLazy",
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      event = "VeryLazy",
    },
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    { "ray-x/guihua.lua", lazy = true },
  },

  event = "CmdlineEnter",

  config = function()
    require("go").setup()
  end,

  ft = { "go", "gomod" },
}
