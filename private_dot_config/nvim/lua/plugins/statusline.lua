return {
  "nvim-lualine/lualine.nvim",

  event = "VeryLazy",

  dependencies = {
    {
      "f-person/git-blame.nvim",

      event = "VeryLazy",

      opts = {
        date_format = "%r",
        display_virtual_text = 0,
      },

      keys = {
        { "<leader>co", "<cmd>GitBlameOpenCommitURL<cr>" },
        { "<leader>fo", "<cmd>GitBlameOpenFileURL<cr>" },
      },
    },
  },

  config = function()
    local git_blame = require("gitblame")
    local lazy_status = require("lazy.status")
    require("lualine").setup({
      options = {
        theme = "dracula",
      },
      sections = {
        lualine_c = {
          { "filename", path = 1 },
          {
            git_blame.get_current_blame_text,
            cond = git_blame.is_blame_text_available,
          },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "ff9e64" },
          }
        },
      },
    })
  end,
}
