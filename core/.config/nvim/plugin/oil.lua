local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/stevearc/oil.nvim
vim.pack.add({
  { src = gh("nvim-mini/mini.icons") },
  { src = gh("stevearc/oil.nvim") },
}, { confirm = false })

require("mini.icons").setup()
require("oil").setup({
  default_file_exporer = true,
  keymaps = {
    ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "[oil] Open in a vertical split" },
    ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "[oil] Open in a horizontal split" },
    ["<C-r>"] = "actions.refresh",
    -- disable defaults that conflict with other keymaps
    ["<C-h>"] = false, -- Navigator
    ["<C-l>"] = false, -- Navigator
    ["<C-s>"] = false, -- default vertical split, replaced by <C-v>
    ["~"] = false
  },
  view_options = { show_hidden = true },
})

k.set("n", "-", "<cmd>:Oil<cr>", { desc = "[oil] Open parent directory" })
