local gh = require("utils").gh

-- https://github.com/lewis6991/gitsigns.nvim
vim.pack.add({
  { src = gh("lewis6991/gitsigns.nvim") },
})

require("gitsigns").setup()
