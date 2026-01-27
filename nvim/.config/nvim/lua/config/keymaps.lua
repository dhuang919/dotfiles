local k = vim.keymap

-- disable command mode
k.set("n", "Q", "")
k.set("n", "q:", "")

-- unhighlight with esc
k.set("n", "<Esc>", ":noh<cr>", { desc = "Unhighlight" })

k.set("n", "<leader>w", ":wa<cr>", { desc = "Write all buffers", noremap = true, silent = true })

-- copy file path to clipboard
k.set("n", "<leader>yp", ":let @+=expand('%:.')<cr>", { desc = "Copy relative path" })
k.set("n", "<leader>yP", ":let @+=@%<cr>", { desc = "Copy absolute path" })

-- lazy.nvim ui
k.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy plugin manager" })

k.set("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
end, { desc = "Show diagnostics in float" })

-- mason ui
k.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })

-- disable mouse/trackpad scrolling
local modes = { "n", "v", "i" }
local scroll_keys =
  { "<ScrollWheelUp>", "<ScrollWheelDown>", "<ScrollWheelLeft>", "<ScrollWheelRight>" }

for _, mode in ipairs(modes) do
  for _, key in ipairs(scroll_keys) do
    k.set(mode, key, "<Nop>", { silent = true })
  end
end
