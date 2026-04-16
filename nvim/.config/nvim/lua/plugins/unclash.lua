return {
  "madmaxieee/unclash.nvim",
  lazy = false, -- unclash is lazy-loaded by default
  opts = {},
  keys = {
    { "<leader>uo", "<cmd>UnclashOpenMergeEditor<cr>",  desc = "[unclash] Open Merge Editor"  },
    { "<leader>uc", "<cmd>UnclashAcceptCurrent<cr>",  desc = "[unclash] Accept Current"  },
    { "<leader>ui", "<cmd>UnclashAcceptIncoming<cr>",  desc = "[unclash] Accept Incoming"  },
    { "<leader>ub", "<cmd>UnclashAcceptBoth<cr>",  desc = "[unclash] Accept Both"  },
  },
}
