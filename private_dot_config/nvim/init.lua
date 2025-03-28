-- space as leader
vim.g.mapleader = " "

require("config.autocmds")
require("config.lazy")

-- NOTE: formatoptions set in autocmds.lua
-- https://neovim.discourse.group/t/options-formatoptions-not-working-when-put-in-init-lua/3746
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.showbreak = string.rep(" ", 4) -- long lines wrap smartly
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
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99

vim.g.python3_host_prog = vim.fn.expand("~/nvim_venv/bin/python")

-- disable to allow after/ftplugin settings work
vim.g.editorconfig = false

-- custom stuff

-- unhighlight with esc
vim.keymap.set("n", "<Esc>", ":noh<cr>")

-- prev/next buffers
vim.keymap.set("n", "[b", ":bprev<cr>", { noremap = true })
vim.keymap.set("n", "]b", ":bnext<cr>", { noremap = true })

-- set line number colors in gutter
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FB508F", bold = true })
vim.api.nvim_set_hl(0, "Cursor", { reverse = true })

-- disabled stuff
-- command mode
vim.keymap.set("n", "Q", "")
vim.keymap.set("n", "q:", "")
