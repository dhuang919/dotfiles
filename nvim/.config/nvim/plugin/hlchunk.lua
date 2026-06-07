local gh = require("utils").gh

-- https://github.com/shellRaining/hlchunk.nvim
vim.pack.add({
  { src = gh("shellRaining/hlchunk.nvim") },
}, { confirm = false })

require("hlchunk").setup({
  indent = {
    enable = true,
    chars = {
      "│",
      "¦",
      "┆",
      "┊",
    },
  },
})
