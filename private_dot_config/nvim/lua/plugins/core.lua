return {
  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
  },
  {
    "Vimjas/vim-python-pep8-indent",
    event = "VeryLazy",
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.gitblame_display_virtual_text = 0
      require("gitblame").setup({
        enabled = false,
      })
    end,
    keys = {
      { "<leader>co", "<cmd>GitBlameOpenCommitURL<cr>" },
      { "<leader>fo", "<cmd>GitBlameOpenFileURL<cr>" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
  },
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    keys = {
      {
        "<leader>S",
        '<cmd>lua require("spectre").toggle()<CR>',
        desc = "Toggle Spectre",
      },
      {
        "<leader>sw",
        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        desc = "Search current word",
      },
      {
        "<leader>sw",
        '<esc><cmd>lua require("spectre").open_visual()<CR>',
        "v",
        desc = "Search current word",
      },
      {
        "<leader>sp",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        desc = "Search on current file",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    config = true,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
}
