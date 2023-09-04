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
    },
  },

  config = function()
    local git_blame = require("gitblame")
    require("lualine").setup({
      options = {
        theme = "dracula",
      },
      sections = {
        lualine_c = {
          { "filename", path = 1 },
          { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
        },
      },
    })
  end,
}
