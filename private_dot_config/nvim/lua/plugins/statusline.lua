return {
  "nvim-lualine/lualine.nvim",

  event = "VeryLazy",

  dependencies = {
    {
      "f-person/git-blame.nvim",

      event = "VeryLazy",

      keys = {
        { "<leader>co", "<cmd>GitBlameOpenCommitURL<cr>" },
        { "<leader>fo", "<cmd>GitBlameOpenFileURL<cr>" },
      },
    },
  },

  opts = {
    options = {
      theme = "ayu_dark",
    },
    sections = {
      lualine_c = {
        { "filename", path = 1 },
      },
    },
    inactive_sections = {
      lualine_c = {
        { "filename", path = 1 },
      },
    },
  },
}
