-- File change settings stolen from https://unix.stackexchange.com/a/383044/517031
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
  pattern = { "*" },
})

-- Notification after file change
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
  pattern = { "*" },
})
