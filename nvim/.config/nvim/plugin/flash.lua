local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/folke/flash.nvim
vim.pack.add({
  { src = gh("folke/flash.nvim") },
})

require("flash").setup()

k.set(
  { "n", "x", "o" },
  "s",
  function()
    require("flash").jump()
  end,
  { desc = "Flash" }
)
