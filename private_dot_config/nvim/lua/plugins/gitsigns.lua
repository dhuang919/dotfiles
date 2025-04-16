return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    current_line_blame = false,
    current_line_blame_formatter = "<author> | <author_time:%R> | <summary>",
    current_line_blame_opts = { delay = 200 },
  },
  keys = {
    {
      "<leader>tb",
      "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>",
      desc = "Gitsigns toggle line blame",
    },
  },
}
