local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- File change settings stolen from https://unix.stackexchange.com/a/383044/517031
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
  pattern = { "*" },
})

-- Notification after file change
autocmd({ "FileChangedShellPost" }, {
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
  pattern = { "*" },
})

autocmd("BufEnter", {
  desc = "Don't extend comments to newlines with o/O",
  group = augroup("AutoComment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "o" })
  end,
})
