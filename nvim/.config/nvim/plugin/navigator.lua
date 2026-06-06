local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/numToStr/Navigator.nvim
vim.pack.add({
  { src = gh("numToStr/Navigator.nvim") },
})

require("Navigator").setup({
  auto_save = "all",
})

k.set("n", "<C-h>", "<cmd>NavigatorLeft<cr>", { desc = "NavigatorLeft" } )
k.set("n", "<C-j>", "<cmd>NavigatorDown<cr>", { desc = "NavigatorDown" } )
k.set("n", "<C-k>", "<cmd>NavigatorUp<cr>", { desc = "NavigatorUp" } )
k.set("n", "<C-l>", "<cmd>NavigatorRight<cr>", { desc = "NavigatorRight" } )
