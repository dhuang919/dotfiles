return {
  "nvim-tree/nvim-tree.lua",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
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
