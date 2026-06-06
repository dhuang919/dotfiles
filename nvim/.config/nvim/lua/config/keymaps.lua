local k = vim.keymap

-- disable command mode
k.set("n", "Q", "")
k.set("n", "q:", "")

-- unhighlight with esc
k.set("n", "<Esc>", ":noh<cr>", { desc = "Unhighlight" })

k.set("n", "<leader>w", ":wa<cr>", { desc = "Write all buffers", noremap = true, silent = true })

k.set("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
end, { desc = "Show diagnostics in float" })

-- mason ui
k.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })

-- insert markdown code block
k.set("n", "<leader>`", "i```<CR><CR>```<Esc>kA", { desc = "Insert code block" })

-- disable mouse/trackpad scrolling
local modes = { "n", "v", "i" }
local scroll_keys =
  { "<ScrollWheelUp>", "<ScrollWheelDown>", "<ScrollWheelLeft>", "<ScrollWheelRight>" }

for _, mode in ipairs(modes) do
  for _, key in ipairs(scroll_keys) do
    k.set(mode, key, "<Nop>", { silent = true })
  end
end

