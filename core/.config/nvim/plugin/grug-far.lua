local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/MagicDuck/grug-far.nvim
vim.pack.add({
  { src = gh("MagicDuck/grug-far.nvim") },
}, { confirm = false })

local gf = require("grug-far")
gf.setup()

k.set(
  {"n", "v"},
  "<leader>gr",
  function() gf.open({ transient = true }) end,
  { desc = "Search and Replace"}
)
