return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto",
      globalstatus = false,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
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
