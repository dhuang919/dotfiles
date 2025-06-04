return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  opts = {
    use_icons = false,
  },
  keys = {
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>dr", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview repo history" },
    { "<leader>df", "<cmd>DiffviewFileHistory --follow %<cr>", desc = "Diffview file history" },
    { "<leader>dl", "<cmd>.DiffviewFileHistory --follow %<cr>", desc = "Diffview line history" },
    {
      "<leader>dl",
      "<esc><cmd>'<,'>DiffviewFileHistory --follow<cr>",
      mode = "v",
      desc = "Diffview range history",
    },
  },
}
