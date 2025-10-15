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
  group = augroup("TrimWhtspc", { clear = true }),
  desc = "Trim trailing whitespace (files only)",
  callback = function(args)
    local buf = args.buf

    -- skip unmodifiable/readonly
    if vim.bo[buf].buftype ~= "" or vim.bo[buf].filetype == "oil"
       or not vim.bo[buf].modifiable or vim.bo[buf].readonly then
      return
    end

    -- preserve cursor/view; don't clobber jumplist or search register
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! keepjumps keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
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

local function jumpWithVirtLineDiags(jumpCount)
  -- https://www.reddit.com/r/neovim/comments/1jm5atz/comment/mk9w6v0
  pcall(vim.api.nvim_del_augroup_by_name, "jumpWithVirtLineDiags") -- prevent autocmd for repeated jumps

  vim.diagnostic.jump({ count = jumpCount })

  local initialVirtTextConf = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
  })

  vim.defer_fn(function() -- deferred to not trigger by jump itself
    vim.api.nvim_create_autocmd("CursorMoved", {
      desc = "User(once): Reset diagnostics virtual lines",
      once = true,
      group = vim.api.nvim_create_augroup("jumpWithVirtLineDiags", {}),
      callback = function()
        vim.diagnostic.config({ virtual_lines = false, virtual_text = initialVirtTextConf })
      end,
    })
  end, 1)
end

autocmd("LspAttach", {
  desc = "LSP key bindings",
  callback = function(event)
    vim.keymap.set(
      "n",
      "K",
      vim.lsp.buf.hover,
      { desc = "LSP Hover", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "<leader>rn",
      "<cmd>lua vim.lsp.buf.rename()<cr>",
      { desc = "LSP Rename", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "gd",
      vim.lsp.buf.definition,
      { desc = "LSP Go To Definition", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "gD",
      vim.lsp.buf.declaration,
      { desc = "LSP Go To Declaration", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "gi",
      vim.lsp.buf.implementation,
      { desc = "LSP Go To Implementation", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "gt",
      vim.lsp.buf.type_definition,
      { desc = "LSP Go To Type Definition", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "gr",
      vim.lsp.buf.references,
      { desc = "LSP References", buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "gs",
      vim.lsp.buf.signature_help,
      { desc = "LSP Signature Help", buffer = event.buf }
    )
    vim.keymap.set("n", "<leader>ge", function()
      jumpWithVirtLineDiags(1)
    end, { desc = "LSP Next Diagnostic", buffer = event.buf })
    vim.keymap.set("n", "<leader>gE", function()
      jumpWithVirtLineDiags(-1)
    end, { desc = "LSP Prev Diagnostic", buffer = event.buf })
  end,
})
