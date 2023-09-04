return {
  "ray-x/go.nvim",

  dependencies = {
    "mfussenegger/nvim-dap",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "ray-x/guihua.lua",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },

  event = "CmdlineEnter",

  config = function()
    require("go").setup()
  end,

  ft = { "go", "gomod" },
}
