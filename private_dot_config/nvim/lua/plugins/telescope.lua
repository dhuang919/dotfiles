return {
  "nvim-telescope/telescope.nvim",

  event = "VeryLazy",

  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      event = "VeryLazy",
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
    {
      "nvim-telescope/telescope-frecency.nvim",
      event = "VeryLazy",
    },
  },

  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("frecency")
  end,

  opts = {
    defaults = {
      file_ignore_patterns = { "^.git/" },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--sortr=modified",
      },
    },
    extensions = {
      live_grep_args = {
        auto_quoting = false,
      },
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--color=never", "--sortr=modified" },
        hidden = true,
      },
    },
  },

  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    {
      "<leader>fg",
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
      desc = "Telescope live grep args",
    },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
    { "<leader>fc", "<cmd>Telescope frecency<cr>", desc = "Telescope frecency file finder" },
  },
}
