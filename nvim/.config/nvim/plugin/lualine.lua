local gh = require("utils").gh

-- https://github.com/nvim-lualine/lualine.nvim
vim.pack.add({
  { src = gh("nvim-lualine/lualine.nvim"), version = vim.version.range("*") },
})

require("lualine").setup({
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
})
