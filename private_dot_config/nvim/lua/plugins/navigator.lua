local utils = require("utils")

return {
  "numToStr/Navigator.nvim",
  event = "VeryLazy",
  opts = {
    auto_save = "all",
  },
  keys = function()
    local keys = {
      { "<C-h>", "<cmd>NavigatorLeft<cr>", desc = "NavigatorLeft" },
      { "<C-j>", "<cmd>NavigatorDown<cr>", desc = "NavigatorDown" },
      { "<C-k>", "<cmd>NavigatorUp<cr>", desc = "NavigatorUp" },
      { "<C-l>", "<cmd>NavigatorRight<cr>", desc = "NavigatorRight" },
    }
    if utils.is_ssh() then
      vim.list_extend(keys, {
        { "<M-h>", "<cmd>NavigatorLeft<cr>", desc = "NavigatorLeft" },
        { "<M-j>", "<cmd>NavigatorDown<cr>", desc = "NavigatorDown" },
        { "<M-k>", "<cmd>NavigatorUp<cr>", desc = "NavigatorUp" },
        { "<M-l>", "<cmd>NavigatorRight<cr>", desc = "NavigatorRight" },
      })
    end
    return keys
  end,
}
