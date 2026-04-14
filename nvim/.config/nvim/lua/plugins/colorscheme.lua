return {
  "webhooked/kanso.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanso").setup({
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
  end,
}
