local gh = require("utils").gh

-- https://github.com/webhooked/kanso.nvim
vim.pack.add({
  { src = gh("webhooked/kanso.nvim") },
}, { confirm = false })

require("kanso").setup({
  transparent = true,
  overrides = function()
    return {
      LineNr = { fg = "#727272" },           -- absolute line numbers
      LineNrAbove = { fg = "#2266aa" },      -- relative lines above cursor
      LineNrBelow = { fg = "#b84069" },      -- relative lines below cursor
      CursorLineNr = { fg = "#000000" },     -- current line number
      WinSeparator = { fg = "#000000" },     -- border between splits
      NormalNC = { bg = "#dce0e8" },         -- dim inactive splits (Catppuccin Latte mantle, matches tmux)
    }
  end,
})

vim.cmd.colorscheme("kanso-pearl")
