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
        { "filename", path = 3 },
      },
    },
    inactive_sections = {
      lualine_c = {
        { "filename", path = 3 },
      },
    },
  },
}
