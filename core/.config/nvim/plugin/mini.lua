local gh = require("utils").gh

-- https://github.com/nvim-mini/mini.nvim
vim.pack.add({
  { src = gh("nvim-mini/mini.ai") },
  { src = gh("nvim-mini/mini.comment") },
  { src = gh("nvim-mini/mini.splitjoin") },
  { src = gh("nvim-mini/mini.surround") },
}, { confirm = false })

require("mini.ai").setup()
require("mini.comment").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup({
  mappings = {
    add = "ys", -- sa
    delete = "ds", -- sd
    find = "", -- sf
    find_left = "", -- sF
    highlight = "", -- sh
    replace = "cs", -- sr
    update_n_lines = "", -- sn
  },
  search_method = "cover_or_next",
})
