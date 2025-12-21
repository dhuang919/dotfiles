return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    message_template = "<author> | <date> | <summary>",
    date_format = "%m-%d-%y %H:%M:%S",
  },
  keys = {
    { "<leader>tb", "<cmd>GitBlameToggle<cr>" },
    { "<leader>gboc", "<cmd>GitBlameOpenCommitURL<cr>" },
    { "<leader>gbcc", "<cmd>GitBlameCopyCommitURL<cr>" },
    { "<leader>gbof", "<cmd>GitBlameOpenFileURL<cr>" },
    { "<leader>gbcf", "<cmd>GitBlameCopyFileURL<cr>" },
  },
}
