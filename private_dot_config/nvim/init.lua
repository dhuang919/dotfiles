require("config.autocmds")
require("config.lazy")

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- NOTE: formatoptions set in autocmds.lua
-- https://neovim.discourse.group/t/options-formatoptions-not-working-when-put-in-init-lua/3746
vim.o.expandtab = true
vim.o.wrap = true
vim.o.breakindent = true
vim.o.showbreak = string.rep(" ", 3) -- long lines wrap smartly
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.swapfile = false

-- Use treesitter for folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99

vim.g.python3_host_prog = vim.fn.expand("~/nvim_venv/bin/python")

-- Disable to allow after/ftplugin settings work
vim.g.editorconfig = false

-- Custom stuff

-- Unhighlight with esc
vim.keymap.set("n", "<Esc>", ":noh<cr>")

-- Buffers
-- Easily view and switch
vim.keymap.set("n", "gb", ":ls", { noremap = true })

-- Prev/next buffers
vim.keymap.set("n", "[b", ":bprev<cr>", { noremap = true })
vim.keymap.set("n", "]b", ":bnext<cr>", { noremap = true })

-- Open oil.nvim
vim.keymap.set("n", "-", "<cmd>:Oil<cr>")

-- Set line number colors in gutter
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FB508F", bold = true })

-- Disabled stuff
-- Command mode
vim.keymap.set("n", "Q", "")
vim.keymap.set("n", "q:", "")
