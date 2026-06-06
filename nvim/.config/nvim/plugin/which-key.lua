local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/folke/which-key.nvim
vim.pack.add({
  { src = gh("folke/which-key.nvim"), version = vim.version.range("*") },
})

require("which-key").setup()

k.set(
  "n",
  "<leader>?",
  function()
    require("which-key").show({ global = false })
  end,
  { desc = "[which-key] Buffer local keymaps" }
)
k.set(
  "n",
  "<leader>??",
  function()
    require("which-key").show({ global = true })
  end,
  { desc = "[which-key] Buffer global keymaps" }
)
