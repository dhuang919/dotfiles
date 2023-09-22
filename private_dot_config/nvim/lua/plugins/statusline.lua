return {
  "nvim-lualine/lualine.nvim",

  event = "VeryLazy",

  opts = {
    options = {
      theme = "ayu_dark",
    },
    sections = {
      lualine_b = {
        { "branch" },
      },
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

  dependencies = {
    {
      "f-person/git-blame.nvim",

      event = "VeryLazy",

      -- opts = {
      --   enabled = false,
      -- },

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
  },
}
