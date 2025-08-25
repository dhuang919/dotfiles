vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.autocmds")
require("config.lazy")

-- NOTE: formatoptions set in autocmds.lua
-- https://neovim.discourse.group/t/options-formatoptions-not-working-when-put-in-init-lua/3746
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.linebreak = true
vim.o.mouse = ""
vim.o.number = true
vim.o.showbreak = string.rep(" ", 2) -- long lines wrap smartly
vim.o.showmode = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.wrap = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- use treesitter for folding
vim.o.foldmethod = "expr"
vim.o.foldlevelstart = 99
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.g.python3_host_prog = vim.fn.expand("~/nvim_venv/bin/python")

-- disable to allow after/ftplugin settings work
vim.g.editorconfig = false

-- custom stuff

-- disabled
-- command mode
vim.keymap.set("n", "Q", "")
vim.keymap.set("n", "q:", "")

-- unhighlight with esc
vim.keymap.set("n", "<Esc>", ":noh<cr>")

-- prev/next buffers
vim.keymap.set("n", "[b", ":bprev<cr>", { noremap = true })
vim.keymap.set("n", "]b", ":bnext<cr>", { noremap = true })

vim.keymap.set("n", "<leader>o", "o<esc>>>A ", { desc = "New indented line" })
vim.keymap.set(
  "n",
  "<leader>w",
  ":wa<cr>",
  { desc = "Write all buffers", noremap = true, silent = true }
)

-- set line number colors in gutter
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#98d2f4" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#cccccc" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#fd9dc0" })
vim.api.nvim_set_hl(0, "Cursor", { reverse = true })

-- dynamically enable lsps
local servers = require("lsp.servers")

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
end

vim.lsp.enable(vim.tbl_keys(servers))
