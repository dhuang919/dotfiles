return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  opts = {
    use_icons = false,
  },
  keys = {
    { "<leader>hc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>hh", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
    { "<leader>hf", "<cmd>DiffviewFileHistory --follow %<cr>", desc = "File history" },
    { "<leader>hl", "<cmd>.DiffviewFileHistory --follow %<cr>", desc = "Line history" },
    {
      "<leader>hl",
      "<esc><cmd>'<,'>DiffviewFileHistory --follow<cr>",
      mode = "v",
      desc = "Range history",
    },
  },
}
