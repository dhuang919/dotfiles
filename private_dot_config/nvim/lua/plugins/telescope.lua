return {
  "nvim-telescope/telescope.nvim",

  event = "VeryLazy",

  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      event = "VeryLazy"
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      event = "VeryLazy",
    },
  },

  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,

  opts = {
    pickers = {
      find_files = {
        hidden = true,
      },
    },
  },

  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
  },
}
