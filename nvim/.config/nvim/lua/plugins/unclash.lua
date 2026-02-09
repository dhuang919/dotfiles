return {
  "madmaxieee/unclash.nvim",
  lazy = false, -- unclash is lazy-loaded by default
  opts = {},
  keys = {
    { "<leader>co", "<cmd>UnclashOpenMergeEditor<cr>",  desc = "[unclash] Open Merge Editor"  },
    { "<leader>cc", "<cmd>UnclashAcceptCurrent<cr>",  desc = "[unclash] Accept Current"  },
    { "<leader>ci", "<cmd>UnclashAcceptIncoming<cr>",  desc = "[unclash] Accept Incoming"  },
    { "<leader>cb", "<cmd>UnclashAcceptBoth<cr>",  desc = "[unclash] Accept Both"  },
  },
}
