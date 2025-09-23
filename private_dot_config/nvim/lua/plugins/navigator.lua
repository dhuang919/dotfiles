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
    if vim.env.SSH_CLIENT or vim.env.SSH_TTY then
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
