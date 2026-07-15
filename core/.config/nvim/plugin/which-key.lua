local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/folke/which-key.nvim
vim.pack.add({
  { src = gh("folke/which-key.nvim") },
}, { confirm = false })

local wk = require("which-key")
wk.setup()

k.set(
  "n",
  "<leader>?",
  function()
    wk.show({ global = false })
  end,
  { desc = "[which-key] Buffer local keymaps" }
)
k.set(
  "n",
  "<leader>??",
  function()
    wk.show({ global = true })
  end,
  { desc = "[which-key] Buffer global keymaps" }
)
