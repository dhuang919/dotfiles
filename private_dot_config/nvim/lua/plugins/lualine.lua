return {
  "nvim-lualine/lualine.nvim",

  event = "VeryLazy",

  opts = {
    options = {
      theme = "dracula",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        {
          "filename",
          path = 1,
        },
      },
    },
  },
}
