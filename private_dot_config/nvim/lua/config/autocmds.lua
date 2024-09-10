local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Auto-refresh files after changes stolen from https://unix.stackexchange.com/a/383044/517031
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
    vim.opt_local.formatoptions:append("r")
    vim.opt_local.formatoptions:remove("c")
    vim.opt_local.formatoptions:remove("o")
  end,
})

autocmd("BufWritePre", {
  desc = "Auto-format go",
  pattern = "*.go",
  group = augroup("GoFormat", {}),
  callback = function()
    require("go.format").goimport()
  end,
})

autocmd("BufWritePre", {
  desc = "Trim trailing whitespace",
  pattern = { "*" },
  group = augroup("TrimWhtspc", {}),
  command = [[%s/\s\+$//e]],
})

autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = vim.fn.expand("~") .. "/dev/notes/*.md",
  desc = "Set conceallevel in Obsidian vault only",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

-- toggle relative line numbers based on mode
local numtoggle_augroup = augroup("numbertoggle", {})
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = numtoggle_augroup,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = numtoggle_augroup,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd("redraw")
    end
  end,
})
