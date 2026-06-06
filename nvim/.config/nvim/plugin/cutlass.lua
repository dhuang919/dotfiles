local gh = require("utils").gh

-- https://github.com/gbprod/cutlass.nvim
-- Overrides delete operations to just delete and not yank
vim.pack.add({
  { src = gh("gbprod/cutlass.nvim"), version = vim.version.range("*") },
})

require("cutlass").setup({
  exclude = { "ns", "nS" }, -- flash.nvim
  registers = {
    delete = "d",
    change = "c",
  },
})
