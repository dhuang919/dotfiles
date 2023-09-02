return {
  "nvim-tree/nvim-tree.lua",

  config = true,

  lazy = false,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  keys = {
    { "<C-n>", ":NvimTreeToggle<cr>" },
  },
}
