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
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
      event = "VeryLazy",
    },
  },

  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
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
    { "<leader>fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
  },
}
