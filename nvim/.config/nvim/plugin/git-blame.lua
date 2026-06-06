local k = vim.keymap
local gh = require("utils").gh

--
vim.pack.add({
  { src = gh("f-person/git-blame.nvim"), version = vim.version.range("*") },
})

require("gitblame").setup({
  enabled = false, -- toggle with key binding
  message_template = "<author> | <date> | <summary>",
  date_format = "%m-%d-%y %H:%M:%S",
})

k.set("n", "<leader>tb", "<cmd>GitBlameToggle<cr>")
k.set("n", "<leader>gboc", "<cmd>GitBlameOpenCommitURL<cr>")
k.set("n", "<leader>gbcc", "<cmd>GitBlameCopyCommitURL<cr>")
k.set("n", "<leader>gbof", "<cmd>GitBlameOpenFileURL<cr>")
k.set("n", "<leader>gbcf", "<cmd>GitBlameCopyFileURL<cr>")
