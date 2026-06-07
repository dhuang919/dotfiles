local gh = require("utils").gh

-- https://github.com/Bekaboo/dropbar.nvim
vim.pack.add({
  { src = gh("Bekaboo/dropbar.nvim") },
}, { confirm = false })

require("dropbar").setup()
