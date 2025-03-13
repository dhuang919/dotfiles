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
  desc = "Auto-format go",
  pattern = "*.go",
  group = augroup("GoFormat", {}),
  callback = function()
    require("go.format").goimport()
  end,
})

autocmd("BufWritePre", {
  desc = "Trim trailing whitespace",
  pattern = "*",
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
  desc = "Configs specific to files in Obsidian vault",
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
  desc = "Continue bulleted lists with o/O in markdown only",
  callback = function()
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
  end,
})

-- coupled with lsp.lua plugin
autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  end,
})
