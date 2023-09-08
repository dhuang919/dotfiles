return {
  "RRethy/vim-illuminate",
  "Vimjas/vim-python-pep8-indent",
  "christoomey/vim-tmux-navigator",
  "nvim-pack/nvim-spectre",
  "tpope/vim-commentary",
  "tpope/vim-surround",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
}
