return {
  "webhooked/kanso.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanso").setup({
      overrides = function()
        return {
          LineNr = { fg = "#cccccc" },
          LineNrAbove = { fg = "#98d2f4" },
          LineNrBelow = { fg = "#fd9dc0" },
          CursorLineNr = { fg = "#ffffff" },
          WinSeparator = { fg = "#ffffff" },
        }
      end,
    })
    vim.cmd.colorscheme("kanso-zen")
  end,
}
