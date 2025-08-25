local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- https://neovim.io/doc/user/api.html#nvim_create_autocmd()

autocmd("FileType", {
  pattern = "*",
  desc = "formatoptions override because setting them in init.lua gets overwritten",
  group = augroup("formatoptions", {}),
  callback = function()
    -- n: recognize numbered lists
    -- r: continue comments with <cr> in insert mode
    -- j: rm comment leader when it makes sense when joining lines
    vim.opt.formatoptions = "nrj"
  end,
})

autocmd("BufWritePre", {
  desc = "Trim trailing whitespace",
  pattern = "*",
  group = augroup("TrimWhtspc", {}),
  command = [[%s/\s\+$//e]],
})

local prev_reg0_content = vim.fn.getreg("0")
autocmd("TextYankPost", {
  desc = "Shift yanks through registers (yank-ring)",
  callback = function()
    -- https://www.reddit.com/r/neovim/comments/1jv03t1/comment/mm9dndu
    -- shift numbered registers up (1 becomes 2, etc.)
    local ev = vim.v.event
    if ev.operator == "y" then
      for i = 9, 2, -1 do
        vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
      end
      vim.fn.setreg("1", prev_reg0_content)
      prev_reg0_content = vim.fn.getreg("0")
    end
    vim.highlight.on_yank()
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = vim.fn.expand("~") .. "/dev/notes/*.md",
  desc = "Conceal level specifically for Obsidian markdown files",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

local numtoggle_augroup = augroup("numbertoggle", {})
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  desc = "Turn relative line numbers on",
  group = numtoggle_augroup,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  desc = "Turn relative line numbers off",
  group = numtoggle_augroup,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd("redraw")
    end
  end,
})

autocmd("FileType", {
  pattern = "markdown",
  desc = "Markdown-specific settings",
  callback = function()
    -- continue bulleted lists with o/O in markdown only
    vim.opt_local.formatoptions:append("o")
    vim.opt_local.comments = {
      "b:- [ ]",
      "b:- [x]",
      "b:- [~]",
      "b:- [!]",
      "b:- [>]",
      "b:-",
      "b:*",
    }
    -- key binding for scratch headers
    vim.keymap.set("n", "<leader>h2", function()
      local days = {
        Sunday = "sun",
        Monday = "mon",
        Tuesday = "tues",
        Wednesday = "wed",
        Thursday = "thurs",
        Friday = "fri",
        Saturday = "sat",
      }
      local date = os.date("%m/%d/%y")
      local weekday = days[os.date("%A")]
      -- 01/01/25 mon w newline after
      local lines = { "## " .. date .. " " .. weekday, "" }
      vim.api.nvim_put(lines, "l", true, true)
      vim.api.nvim_feedkeys("kO", "n", false)
    end, { desc = "Insert H2 markdown header with date and day of week" })
  end,
})

autocmd("CursorHold", {
  desc = "Show errors and warnings in a floating window",
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
  end,
})
