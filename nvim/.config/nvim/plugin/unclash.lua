local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/madmaxieee/unclash.nvim
vim.pack.add({
  { src = gh("madmaxieee/unclash.nvim") },
})

k.set("n", "<leader>uo", "<cmd>UnclashOpenMergeEditor<cr>", { desc = "[unclash] Open Merge Editor" } )
k.set("n", "<leader>uc", "<cmd>UnclashAcceptCurrent<cr>", { desc = "[unclash] Accept Current" })
k.set("n", "<leader>ui", "<cmd>UnclashAcceptIncoming<cr>", { desc = "[unclash] Accept Incoming" })
k.set("n", "<leader>ub", "<cmd>UnclashAcceptBoth<cr>", { desc = "[unclash] Accept Both" })
