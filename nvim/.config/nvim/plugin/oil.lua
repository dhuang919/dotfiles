local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/stevearc/oil.nvim
vim.pack.add({
  { src = gh("nvim-mini/mini.icons"), version = vim.version.range("*") },
  { src = gh("stevearc/oil.nvim"), version = vim.version.range("*") },
})

require("mini.icons").setup()
require("oil").setup({
  default_file_exporer = true,
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-v>"] = {
      "actions.select",
      opts = { vertical = true },
      desc = "Open the entry in a vertical split",
    },
    ["<C-x>"] = {
      "actions.select",
      opts = { horizontal = true },
      desc = "Open the entry in a horizontal split",
    },
    ["<C-t>"] = {
      "actions.select",
      opts = { tab = true },
      desc = "Open the entry in new tab",
    },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = {
      "actions.cd",
      opts = { scope = "tab" },
      desc = ":tcd to the current oil directory",
    },
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
  },
})

k.set("n", "-", "<cmd>:Oil<cr>", { desc = "Open parent directory" })
