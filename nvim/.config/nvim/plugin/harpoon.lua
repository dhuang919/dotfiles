local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/ThePrimeagen/harpoon
vim.pack.add({
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
}, { confirm = false })

local h = require("harpoon").setup()

k.set(
  "n",
  "<leader>a",
  function() h:list():add() end,
  { desc = "Harpoon add" }
)
k.set(
  "n",
  "<leader>h",
  function() h.ui:toggle_quick_menu(h:list()) end,
  { desc = "Harpoon quick menu" }
)
k.set(
  "n",
  "<leader>[",
  function() h:list():prev() end,
  { desc = "Harpoon prev" }
)
k.set(
  "n",
  "<leader>]",
  function() h:list():next() end,
  { desc = "Harpoon next" }
)

for i = 1, 9 do
  k.set(
    "n",
    "<leader>" .. i,
    function()
      h:list():select(i)
    end,
    { desc = "Harpoon to file " .. i }
  )
end
