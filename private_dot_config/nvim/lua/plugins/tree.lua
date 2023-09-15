return {
  "nvim-tree/nvim-tree.lua",

  lazy = false,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  config = function(_, opts)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.o.termguicolors = true
    require("nvim-tree").setup(opts)
  end,

  opts = {
    view = {
      width = 35,
    },
  },

  keys = {
    { "<C-n>", ":NvimTreeToggle<cr>" },
  },
}
