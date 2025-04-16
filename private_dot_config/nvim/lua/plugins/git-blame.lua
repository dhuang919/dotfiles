return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  config = function()
    vim.g.gitblame_display_virtual_text = 0
    require("gitblame").setup({
      enabled = false,
    })
  end,
  keys = {
    { "<leader>oc", "<cmd>GitBlameOpenCommitURL<cr>" },
    { "<leader>of", "<cmd>GitBlameOpenFileURL<cr>" },
  },
}
