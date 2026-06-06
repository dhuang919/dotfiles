local gh = require("utils").gh

-- https://github.com/webhooked/kanso.nvim
vim.pack.add({
  { src = gh("webhooked/kanso.nvim"), version = vim.version.range("*") },
})

require("kanso").setup({
  transparent = true,
  overrides = function()
    return {
      LineNr = { fg = "#727272" },
      LineNrAbove = { fg = "#2266aa" },
      LineNrBelow = { fg = "#b84069" },
      CursorLineNr = { fg = "#000000" },
      WinSeparator = { fg = "#000000" },
    }
  end,
})

vim.cmd.colorscheme("kanso-pearl")
